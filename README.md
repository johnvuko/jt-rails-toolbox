# JTRailsToolboox

JTRailsToolboox contains a list of common libs used for Ruby On Rails development.

## Installation

JTRailsToolboox is distributed as a gem, which is how it should be used in your app.

Include the gem in your Gemfile:

    gem 'jt-rails-toolboox', '~> 1.0'

Create a `jt-toolbox.yml` file:

	rails g rails_toolbox:install

## What's in it?

- [Exception Notification](https://github.com/smartinez87/exception_notification), send email notifications when errors occur
- [paperclip](https://github.com/thoughtbot/paperclip), manage file upload
- [quiet_assets](https://github.com/evrone/quiet_assets), silence assets in log
- [sidekiq](https://github.com/mperham/sidekiq), manage background jobs
- [validates_email_format_of](https://github.com/validates-email-format-of/validates_email_format_of), who doesn't need to validate email format?
- simplified configuration of hostnames and `ActionMailer` with YAML

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
- redis url is by default `"redis://localhost:6379/#{name of your}"`

#### Warning

Don't forget to install redis server and to launch sidekiq with

`bundle exec sidekiq -q default -q mailers`

### Hostname

- `host` is the hostname of your website, it's used for setting the host when you email
- `asset_host` is the hostname of the assets server. By default equal to `host`.
- `cdn_host` is the hostname for serving uploaded files with paperclip. By default equal to `asset_host`.

It's a good practice to have a different domains for your web server and your file server (search "Cookieless Domain" on google for more informations).

### ActionMailer

ActionMailer can be configured easily just with `jt-toolbox.yml` file.

## Author

- [Jonathan Tribouharet](https://github.com/jonathantribouharet) ([@johntribouharet](https://twitter.com/johntribouharet))

## License

JTRailsToolboox is released under the MIT license. See the LICENSE file for more info.

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/jonathantribouharet/jt-rails-toolbox/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

