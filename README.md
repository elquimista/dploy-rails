# dploy-rails

Simple Rails deployer for VPS and Nginx (or similar reverse proxy server) for Rails 5.1 and above.

## Prerequisites

`dploy-rails` assumes the following things:
- Your Rails application is set to run on top of nginx in the remote server. For more details, please read this article here - [How to Setup Rails App with Puma and NGINX](http://swarts.gitlab.io/development/2017/02/03/how-to-setup-rails-app-with-puma-and-nginx.html)
- Rails application codebase is hosted on certain git repository service and deploy key (SSH-key used for read-only purpose) is added to the repository.
- You have `build` script inside `package.json` file.  
  E.g.,
  ```
  "build": "sh -c 'rm -rf public/webpack/production/* || true && bin/rails react_on_rails:locale && bin/rails assets:precompile && yarn webpack:build:production'"
  ```
- You have `start` script inside `package.json` file.
  E.g.,
  ```
  "start": "bundle exec puma -e $RAILS_ENV -p $PORT -b unix://./tmp/sockets/puma.sock --pidfile ./tmp/pids/puma.pid -d"
  ```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dploy-rails'
```

And then execute:

    $ bundle

## Usage

In order for `dploy-rails` to work properly, you need to set the following env variables:
```
DEPLOY_DOMAIN=<IPv4 or canonical domain name>
DEPLOY_USER=<user name you used to use for SSH-ing to the server>
DEPLOY_IDENTITY_FILE=<SSH identity file (private key or pem file)>
DEPLOY_PATH=<Rails application path for deployment on the remote server>
```

This gem will make a new Rails task available. Once you are ready to deploy, just hit the following command in your terminal:

    $ bin/rails deploy

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/knocknock-team/dploy-rails.
