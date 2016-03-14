Gem::Specification.new do |s|
	s.name = 'jt-rails-toolbox'
	s.summary = "Common libs used for Ruby On Rails development."
	s.description = "JTRailsToolbox contains a list of common libs used for Ruby On Rails development."
	s.homepage = 'https://github.com/jonathantribouharet/jt-rails-toolbox'
	s.version = '1.2.2'
	s.files = `git ls-files`.split("\n")
	s.require_paths = ['lib']
	s.authors = ['Jonathan TRIBOUHARET']
	s.email = 'jonathan.tribouharet@gmail.com'
	s.license = 'MIT'
	s.platform = Gem::Platform::RUBY

	s.add_dependency('exception_notification', '~> 4.1')
	s.add_dependency('paperclip', '~> 4.2')
	s.add_dependency('quiet_assets', '~> 1.1')
	s.add_dependency('sidekiq', '~> 3.3')
	s.add_dependency('sinatra') # Admin for sidekiq
	s.add_dependency('validates_email_format_of', '~> 1.6')
	s.add_dependency('rails-i18n', '~> 4.0')
	s.add_dependency('jt-rails-meta', '~> 1.0')
	s.add_dependency('jt-rails-generator-user', '~> 1.0')
	s.add_dependency('jt-rails-tokenizable', '~> 1.0')
end
