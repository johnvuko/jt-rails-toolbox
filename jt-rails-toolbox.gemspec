Gem::Specification.new do |s|
	s.name = 'jt-rails-toolbox'
	s.summary = "Common libs used for Ruby On Rails development."
	s.description = "JTRailsToolbox contains a list of common libs used for Ruby On Rails development."
	s.homepage = 'https://github.com/jonathantribouharet/jt-rails-toolbox'
	s.version = '2.3.0'
	s.files = `git ls-files`.split("\n")
	s.require_paths = ['lib']
	s.authors = ['Jonathan TRIBOUHARET']
	s.email = 'jonathan.tribouharet@gmail.com'
	s.license = 'MIT'
	s.platform = Gem::Platform::RUBY

	s.add_dependency('rails', '~> 5.0')
	
	s.add_dependency('dotenv-rails')
	s.add_dependency('http_accept_language')

	s.add_dependency('exception_notification', '~> 4.1')
	s.add_dependency('airbrake', '~> 5.0')

	s.add_dependency('paperclip', '~> 5.0')
	s.add_dependency('validates_email_format_of', '~> 1.6')
	s.add_dependency('rails-i18n', '~> 5.0')
	s.add_dependency('jt-rails-meta', '~> 1.0')
	s.add_dependency('jt-rails-generator-user', '~> 1.0')
	s.add_dependency('jt-rails-tokenizable', '~> 1.0')

	s.add_dependency('sidekiq', '~> 4.0')
	s.add_dependency('sinatra') # Admin for sidekiq
	s.add_dependency('redis-namespace') # Sidekiq
end
