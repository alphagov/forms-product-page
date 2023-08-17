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

## To get started

To run the project:

```bash
# 1. Install the Ruby bundle
bundle install

# 2. Install npm dependencies
npm install

# 3. Run the 'dev' task to start a local server for development
npm run start
```

## Testing

### RSpec
To run the rspec tests:
```bash
rake test

# Equivalent to:
bundle exec rspec
```
To run the rubocop linter:
```bash
rake lint

# Equivalent to:
bundle exec rubocop

# to fix correctable offenses:
bundle exec rubocop -A
```

You can run the linter and tests in one:
```bash
rake
```
### Jest
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

Run the javascript linter with:

```bash
npm run lint
```

## Support

Raise a Github issue if you need support.

## Explain how users can contribute

We welcome contributions - please read [CONTRIBUTING.md](CONTRIBUTING.md) and the [alphagov Code of Conduct](https://github.com/alphagov/.github/blob/main/CODE_OF_CONDUCT.md) before contributing.

## License

We use the [MIT License](https://opensource.org/licenses/MIT).
