module Jt
	class ToolboxGenerator < Rails::Generators::Base
		source_root File.expand_path("../templates", __FILE__)

		def create_initializer_file
			copy_file "jt-toolbox.yml", "config/jt-toolbox.yml"

			insert_into_file "config/routes.rb", "# https://github.com/mperham/sidekiq/wiki/Monitoring

require 'sidekiq/web'

class AdminConstraint
	def matches?(request)
		return false if !request.session['user_id']

		user = User.find_by_id(request.session['user_id'])
		user && user.is_admin?
	end
end

", before: "Rails.application.routes.draw do"

			route "mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new"

		end
	end
end
