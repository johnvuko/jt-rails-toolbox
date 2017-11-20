# JTRailsToolbox

[![Gem Version](https://badge.fury.io/rb/jt-rails-toolbox.svg)](http://badge.fury.io/rb/jt-rails-toolbox)

JTRailsToolbox contains a list of common libs used for Ruby On Rails development.

## Installation

JTRailsToolbox is distributed as a gem, which is how it should be used in your app.

Include the gem in your Gemfile:

	gem 'jt-rails-toolbox', '~> 2.0'

Create a `jt-toolbox.yml` file:

	rails g jt:toolbox

A simple configuration of `jt-toolbox.yml` file:

```yml
production:
  exception:
    slack:
      webhook_url: https://hooks.slack.com/services/XXXXXXXX
    email_prefix: '[ERROR]'
    sender_address: "Your website <error@example.com>"
    exception_recipients:
      - my_email_for_errors@example.com
  files:
    folder: upload
  mail:
    from: "Your website <contact@example.com>"
    delivery_method: smtp
    smtp_settings:
      address: smtp.gmail.com
      port: 587
      domain: example.com
      user_name: username
      password: password
      authentication: plain
      enable_starttls_auto: true
  hosts:
    host: https://www.example.com
    asset_host: https://asset.example.com
    cdn_host: https://cdn.example.com
  sidekiq:
    redis_url: redis://localhost:6379/my_app
```

## What's in it?

- [http_accept_language](https://github.com/iain/http_accept_language), helps you detect the users preferred language, as sent by the "Accept-Language" HTTP header
- [dotenv](https://github.com/bkeepers/dotenv), load environment variables from .env file
- [Exception Notification](https://github.com/smartinez87/exception_notification), 
send notifications when errors occur (email, slack)
- [paperclip](https://github.com/thoughtbot/paperclip), manage file upload
- [sidekiq](https://github.com/mperham/sidekiq), manage background jobs
- [validates_email_format_of](https://github.com/validates-email-format-of/validates_email_format_of), who doesn't need to validate email format?
- [validates_phone_format_of](https://github.com/jonathantribouharet/validates_phone_format_of), validate phone against E.164 format
- [rails-i18n](https://github.com/svenfuchs/rails-i18n) Default locale data
- [jt-rails-meta](https://github.com/jonathantribouharet/jt-rails-meta) Manage HTML meta tags
- [jt-rails-generator-user](https://github.com/jonathantribouharet/jt-rails-generator-user) Generate a scaffold for user authentication
- [jt-rails-tokenizable](https://github.com/jonathantribouharet/jt-rails-tokenizable) Generate tokens for ActiveRecord models
- [jt-rails-address](https://github.com/jonathantribouharet/jt-rails-address) Helpers for addresses / geolocation management
- [jt-rails-enum](https://github.com/jonathantribouharet/jt-rails-enum) Enum in models
- [validates_timeliness](https://github.com/adzap/validates_timeliness) Date and time validation plugin for ActiveModel
- simplified configuration of hostnames and `ActionMailer` with a YAML file
- some helper methods

### http_accept_language

To install `http_accept_language` you just have to add a line in your `ApplicationController`

```ruby
class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale

end
```

### Dotenv

It's a good practice to not include credentials for third party services in your code. You can defined it in a `.env` file which I recommend to not include in your git repository.

### Exception Notification

If `exception` is not set in `jt-toolbox.yml` file, Exception Notification is disabled.
In addition to the default ignored exceptions, the following exceptions are also muted:

- `ActionController::InvalidCrossOriginRequest`
- `ActionController::InvalidAuthenticityToken`

### Paperclip

- `convert_options` is set to `-strip`, which means all metadata of images are removed, this is used for reduced the weight of images.
- `use_timestamp` is et to `false`, it's a good practice to have unique url for image and url without parameters, instead of using the timestamp we use the fingerprint of the image. [More informations here.](https://github.com/thoughtbot/paperclip#md5-checksum--fingerprint)
- the default fodler of images is `upload` (in public folder)

### Sidekiq

- configured for `ActiveJob`
- configured to send notification error with Exception Notification
- redis url is by default `redis://localhost:6379/0` and the namespace is `#{name of your application}` for production and `#{name of your application}-{environment}` for others.

#### Warning

Don't forget to install redis server and to launch sidekiq with:

```
bundle exec sidekiq -e $RAILS_ENV -q default -q mailers -d -L log/sidekiq.log -P tmp/pids/sidekiq.pid
```

### Hostname

- `host` is the hostname of your website, it's used for setting the host when you email
- `asset_host` is the hostname of the assets server. By default equal to `host`.
- `cdn_host` is the hostname for serving uploaded files with paperclip. By default equal to `asset_host`.

It's a good practice to have a different domains for your web server and your file server (search "Cookieless Domain" on google for more informations).

### ActionMailer

ActionMailer can be configured easily just with `jt-toolbox.yml` file.

### Helper methods

### google_anaytics_tag

It will add automatically in production environment the javascript code for Google Analytics.
You just have add at the end of your `app/views/layouts/application.html.erb` file:

```
<%= google_anaytics_tag 'UA-XXXXXXX-X' %>
```

## Author

- [Jonathan Tribouharet](https://github.com/jonathantribouharet) ([@johntribouharet](https://twitter.com/johntribouharet))

## License

JTRailsToolbox is released under the MIT license. See the LICENSE file for more info.
