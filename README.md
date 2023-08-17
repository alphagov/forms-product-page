# GOV.UK Forms Product Pages

GOV.UK Forms Product Pages consist of the main product page content used for
onboarding new users of GOV.UK Forms, and its supporting pages (for example,
the accessibility statement and privacy policy). It is implemented as a
Rails app.

## Before you start

To run the project you will need to install:

- [Ruby](https://www.ruby-lang.org/en/) - we use version 3 of Ruby. Before
  running the project, double check the [.ruby-version] file to see the exact
  version.
- [Node.js](https://nodejs.org/en/) - the frontend build requires Node.js. We use Node 18 LTS versions.

We recommend using a version manager to install and manage these, such as:

- [RVM](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv) for Ruby
- [nvm](https://github.com/nvm-sh/nvm) for Node.js
- [asdf](https://github.com/asdf-vm/asdf) for both

## Getting started

### Installing for the first time

```bash
# 1. Clone the git repository and change directory to the new folder
git clone git@github.com/alphagov/forms-product-page.git
cd forms-product-page

# 2. Install the Ruby bundle
bundle install

# 3. Install npm dependencies
npm install
```

### Running the app

```bash
# 1. Run the 'dev' task to start a local server for development
./bin/dev
```

## Development tools

### Running the tests

#### RSpec

The app tests are written with [rspec-rails], and you can run them with:

```bash
bundle exec rspec

# This is equivalent to:
rake test
```

#### Jest

To run the Jest tests:

```bash
# For just the unit tests:
npm run test:unit

# to re-run the tests when files change:
npm run test:unit --watch

# For the functional tests:
npm run test:functional

# For both:
npm run tests
```

### Linting

We use [RuboCop GOV.UK] for linting ruby code. To autocorrect issues, run:

```bash
bundle exec rubocop -A
```

We also use [Standard] for linting javascript code:

```bash
npm run lint
```

[RuboCop GOV.UK]: https://github.com/alphagov/rubocop-govuk
[Standard]: https://github.com/standard/standard

### Running tasks with Rake

We have a [Rakefile](./Rakefile) that is set up to follow the [GOV.UK conventions for Rails applications].

To lint your ruby changes and run rspec tests with one command, you can run:

```bash
bundle exec rake
```

[GOV.UK conventions for Rails applications]: https://docs.publishing.service.gov.uk/manual/configure-linting.html#configuring-rails

## Support

Raise a GitHub issue if you need support.

## How to contribute

We welcome contributions - please read [CONTRIBUTING.md](CONTRIBUTING.md) and the [alphagov Code of Conduct](https://github.com/alphagov/.github/blob/main/CODE_OF_CONDUCT.md) before contributing.

## License

We use the [MIT License](https://opensource.org/licenses/MIT).
