Gem::Specification.new do |s|
	s.name = 'jt-rails-toolbox'
	s.summary = "Common libs used for Ruby On Rails development."
	s.description = "JTRailsToolbox contains a list of common libs used for Ruby On Rails development."
	s.homepage = 'https://github.com/jonathantribouharet/jt-rails-toolbox'
	s.version = '2.8.1'
	s.files = `git ls-files`.split("\n")
	s.require_paths = ['lib']
	s.authors = ['Jonathan VUKOVICH TRIBOUHARET']
	s.email = 'jonathan.tribouharet@gmail.com'
	s.license = 'MIT'
	s.platform = Gem::Platform::RUBY

	s.add_dependency('rails', '>= 5')
	
	s.add_dependency('dotenv-rails')
	s.add_dependency('http_accept_language')

	s.add_dependency('exception_notification', '~> 4.1')

	s.add_dependency('paperclip', '~> 5.0')
	s.add_dependency('validates_email_format_of', '~> 1.6')
	s.add_dependency('validates_phone_format_of', '~> 1.0')
	s.add_dependency('rails-i18n', '>= 5')
	s.add_dependency('jt-rails-meta', '~> 1.0')
	s.add_dependency('jt-rails-generator-user', '~> 1.0')
	s.add_dependency('jt-rails-tokenizable', '~> 1.0')
	s.add_dependency('jt-rails-address', '~> 1.0')
	s.add_dependency('jt-rails-enum', '~> 1.0')

	s.add_dependency('sidekiq', '< 6')
	s.add_dependency('redis-namespace')

	s.add_dependency('oj')
	s.add_dependency('oj_mimic_json')
	s.add_dependency('validates_timeliness', '~> 4.0')
end
