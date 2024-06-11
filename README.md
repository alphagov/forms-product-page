# GOV.UK Forms Product Pages [![Tests](https://github.com/alphagov/forms-product-page/actions/workflows/test.yml/badge.svg)](https://github.com/alphagov/forms-product-page/actions/workflows/test.yml)

[GOV.UK Forms Product Pages](https://www.forms.service.gov.uk/) consist of the main product page content used for onboarding new users of GOV.UK Forms, and its supporting pages (for example, the accessibility statement and privacy policy). It is implemented as a Rails app.

## Before you start

To run the project, you will need to install:

- [Ruby](https://www.ruby-lang.org/en/) - we use version 3 of Ruby. Before running the project, double check the [.ruby-version](.ruby-version) file to see the exact version.
- [Node.js](https://nodejs.org/en/) - the frontend build requires Node.js. We use Node 20 LTS versions.

We recommend using a version manager to install and manage these, such as:

- [RVM](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv) for Ruby
- [nvm](https://github.com/nvm-sh/nvm) for Node.js
- [asdf](https://github.com/asdf-vm/asdf) for both

## Getting started

### Installing for the first time

```bash
# 1. Clone the git repository and change directory to the new folder
git clone git@github.com:alphagov/forms-product-page.git
cd forms-product-page

# 2. Run the setup script
./bin/setup
```

### Running the app

You can either run the development task:

```bash
# Run the foreman dev server. This will also start the frontend dev task
./bin/dev
```

or run the rails server:

```bash
# Run a local Rails server
./bin/rails server

# When running the server, you can use any of the frontend tasks, e.g.:
npm run dev
```

## Development tools

### Running the tests

The app tests are written with [rspec-rails] and you can run them with:

```bash
bundle exec rspec
```

There are also unit tests for JavaScript code (look for files named `*.test.js`), written with [Vitest]. You can run those with:

```bash
npm run test
```

[rspec-rails]: https://github.com/rspec/rspec-rails
[Vitest]: https://vitest.dev/

### Linting

We use [RuboCop GOV.UK] for linting Ruby code. To autocorrect issues, run:

```bash
bundle exec rubocop -A
```

We use [JavaScript Standard Style] for our JavaScript code:

```bash
npm run lint
```

On GitHub pull requests, we also check our dependencies for security issues using [bundler-audit]. You can run this locally with:

```bash
bundle audit
```

[RuboCop GOV.UK]: https://github.com/alphagov/rubocop-govuk
[JavaScript Standard Style]: https://github.com/standard/standard
[bundle-audit]: https://github.com/rubysec/bundler-audit

### Running tasks with Rake

We have a [Rakefile](./Rakefile) that is set up to follow the [GOV.UK conventions for Rails applications].

To lint your changes and run tests with one command, you can run:

```bash
bundle exec rake
```

[GOV.UK conventions for Rails applications]: https://docs.publishing.service.gov.uk/manual/configure-linting.html#configuring-rails

## Changing configuration

### Changing settings

Refer to the [the config gem](https://github.com/railsconfig/config#accessing-the-settings-object) to understand the `file based settings` loading order.

To override `file based settings` through `Machine based env variables settings`, you can run:

```bash
cat config/settings.yml
file
  based
    settings
      env1: 'foo'
```

```bash
export SETTINGS__FILE__BASED__SETTINGS__ENV1="bar"
```

```ruby
puts Settings.file.based.setting.env1
bar
```

Refer to the [settings file](config/settings.yml) for all the settings required to run this app

### Configuring Sentry

We use [Sentry] to catch and alert us about exceptions in production apps.

We currently have a very basic setup for Sentry in this repo for testing, which we will continue to build upon.

In order to use Sentry locally, you will need to:

1. Sign in to Sentry using your work Google account.
2. Create a new project.
3. Add the Sentry DSN to your environment as `SETTINGS__SENTRY__DSN`, or add it to a local config file:

```
# config/settings.local.yml

sentry:
  DSN: <DSN from Sentry>
```

If you want to deliberately raise an exception to test, uncomment out the triggers in the [Sentry initializer script](config/initializers/sentry.rb). Whenever you run the app, errors will be raised and should also come through on Sentry.

[Sentry]: https://sentry.io

## Deploying apps

The forms-product-page app is containerised (see [Dockerfile](Dockerfile)) and can be deployed in the same way you'd normally deploy a containerised app.

We host our apps using Amazon Web Services (AWS). You can [read about how deployments happen on our team wiki](https://github.com/alphagov/forms-team/wiki/Deploying-code-changes-AWS), if you have access.

### Logging

- You should configure HTTP access logs in [the application config](./config/application.rb), using [Lograge](https://github.com/roidrage/lograge).
- You should use the [LogEventService](./app/services/log_event_service.rb) and [EventLogger](./app/lib/event_logger.rb) to create any custom log messages. This is independent of any Lograge configuration.
- The output format is JSON, using the [JsonLogFormatter](./app/lib/json_log_formatter.rb) to enable simpler searching and visbility, especially in Splunk.
- Do not use [log_tags](https://guides.rubyonrails.org/configuring.html#config-log-tags), as it breaks the JSON formatting produced by Lograge.

### Updating Docker files

To update the version of [Alpine Linux] and Ruby used in the Dockerfile, use the [update_app_versions.sh script in forms-deploy](https://github.com/alphagov/forms-deploy/blob/main/support/update_app_versions.sh)

[Alpine Linux]: https://www.alpinelinux.org/

## Support

Raise a GitHub issue if you need support.

## How to contribute

We welcome contributions - please read [CONTRIBUTING.md](CONTRIBUTING.md) and the [alphagov Code of Conduct](https://github.com/alphagov/.github/blob/main/CODE_OF_CONDUCT.md) before contributing.

## License

We use the [MIT License](https://opensource.org/licenses/MIT).

<!-- AH: a small meaningless commit to test the path to production -->
