require 'exception_notification'
require 'paperclip'
require 'sidekiq'
require 'validates_email_format_of'
require 'rails_i18n'
require 'jt-rails-meta'
require 'jt-rails-generator-user'
require 'jt-rails-tokenizable'

if Rails.env.development?
	require 'quiet_assets'
end

require 'exception_notification/rails'
require 'exception_notification/sidekiq'

require 'yaml'

module JTRailsToolbox

	class Railtie < ::Rails::Railtie
		
		initializer "jt-rails-toolbox" do |app|
			@params = {}

			if ::File.exists?('config/jt-toolbox.yml')
				yaml = YAML.load_file('config/jt-toolbox.yml')
				if yaml
					@params = yaml[Rails.env.to_s] || {}
				end
			end

			process_params
			configure_exception_notification(app)
			configure_mail(app)
			configure_paperclip(app)
			configure_sidekiq(app)
		end

		def process_params
			@params['files'] ||= {}
			if @params['files']['folder'].nil?
				@params['files']['folder'] = '/upload'
			else
				# Remove end slash
				@params['files']['folder'].sub!(/\/$/, '')

				if !@params['files']['folder'].start_with?('/')
					@params['files']['folder'] = "/#{@params['files']['folder']}"
				end
			end

			@params['mail'] ||= {}
			@params['mail']['delivery_method'] ||= :test
			@params['mail']['delivery_method'] = @params['mail']['delivery_method'].to_sym

			@params['mail']['smtp_settings'] ||= {}
			settings = @params['mail']['smtp_settings'].dup
			@params['mail']['smtp_settings'] = {}
			for key, value in settings
				@params['mail']['smtp_settings'][key.to_sym] = value
			end

			@params['hosts'] ||= {}
			@params['hosts']['host'] ||= 'http://localhost:3000'
			@params['hosts']['asset_host'] ||= @params['hosts']['host']
			@params['hosts']['cdn_host'] ||= @params['hosts']['asset_host']

			@params['sidekiq'] ||= {}
			@params['sidekiq']['redis_url'] ||= "redis://localhost:6379/#{Rails.application.class.parent_name.parameterize}"
		end

		def configure_exception_notification(app)
			return if @params['exception'].nil?

			ExceptionNotification.configure do |config|
				config.ignored_exceptions += ['ActionController::InvalidCrossOriginRequest', 'ActionController::InvalidAuthenticityToken']

				config.add_notifier :email, {
					email_prefix: @params['exception']['email_prefix'],
					sender_address: @params['exception']['sender_address'],
					exception_recipients: @params['exception']['exception_recipients']
				}
			end
		end

		def configure_mail(app)
			ActionMailer::Base.delivery_method = @params['mail']['delivery_method']
			ActionMailer::Base.smtp_settings = @params['mail']['smtp_settings']
			ActionMailer::Base.default_url_options[:host] = @params['hosts']['host']
			ActionMailer::Base.default from: @params['mail']['from']
		end

		def configure_paperclip(app)
			# Strip meta data from images
			Paperclip::Attachment.default_options[:convert_options] = { all: '-strip' }

			# Params in url are bad for SEO, it's better to use fingerprint for having a unique url
			Paperclip::Attachment.default_options[:use_timestamp] = false

			path = "#{@params['files']['folder']}/:class/:attachment/:id/:style/:fingerprint.:content_type_extension"

			Paperclip::Attachment.default_options[:path] = ":rails_root/public/#{path}"
			Paperclip::Attachment.default_options[:url] = "#{@params['hosts']['cdn_host']}#{path}"
			app.config.action_controller.asset_host = @params['hosts']['asset_host']
		end

		def configure_sidekiq(app)
			Sidekiq.configure_server do |config|
				config.redis = { url: @params['sidekiq']['redis_url'] }

				config.error_handlers << Proc.new {|ex, ctx_hash| ExceptionNotifier.notify_exception(ex, data: ctx_hash) }
			end

			Sidekiq.configure_client do |config|
				config.redis = { url: @params['sidekiq']['redis_url'] }
			end

			ActiveJob::Base.queue_adapter = :sidekiq
		end

	end

end