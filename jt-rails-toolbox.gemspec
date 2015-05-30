Gem::Specification.new do |s|
	s.name = 'jt-rails-toolbox'
	s.summary = "Common libs used for Ruby On Rails development."
	s.description = "JTRailsToolboox contains a list of common libs used for Ruby On Rails development."
	s.homepage = 'https://github.com/jonathantribouharet/jt-rails-toolbox'
	s.version = '1.0.1'
	s.files = `git ls-files`.split("\n")
	s.require_paths = ['lib']
	s.authors = ['Jonathan TRIBOUHARET']
	s.email = 'jonathan@siu-soon.com'
	s.license = 'MIT'
	s.platform = Gem::Platform::RUBY

	s.add_dependency('exception_notification', '~> 4.1')
	s.add_dependency('paperclip', '~> 4.2')
	s.add_dependency('quiet_assets', '~> 1.1')
	s.add_dependency('sidekiq', '~> 3.3')
	s.add_dependency('validates_email_format_of', '~> 1.6')
end
