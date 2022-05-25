# GOV.UK Forms Product Pages

GOV.UK Forms Product Pages consist of the main product page content used for onboarding new users of GOV.UK Forms, and its supporting pages (for example, the accessibility statement and privacy policy). It is implemented as a Middleman app.

## Before you start

To run the project you will need to install:

- [Ruby](https://www.ruby-lang.org/en/) - we use version 3 of Ruby. Before running the project, double check the [.ruby-version] file to see the exact version.
- [Node.js](https://nodejs.org/en/) - the frontend build requires Node.js. We use Node 16 LTS versions.
- [Yarn](https://yarnpkg.com/) - we use Yarn rather than `npm` to install and run the frontend.

We recommend using a version manager to install and manage these, such as:

- [RVM](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv) for Ruby
- [nvm](https://github.com/nvm-sh/nvm) for Node.js
- [asdf](https://github.com/asdf-vm/asdf) for both

## Explain how to get started

To run the project:

```bash
# 1. Install the Ruby bundle
bundle install

# 2. Install yarn dependencies
yarn

# Then either:
# 3a. Run the 'dev' task to start a local server for development
yarn run dev

# or:
# 3b: Run the 'build' task to generate the static site for deployment
yarn run build
```

## Support

Raise a Github issue if you need support.

## Explain how users can contribute

We welcome contributions - please read [CONTRIBUTING.md](CONTRIBUTING.md) and the [alphagov Code of Conduct](https://github.com/alphagov/.github/blob/main/CODE_OF_CONDUCT.md) before contributing.

## License

We use the [MIT License](https://opensource.org/licenses/MIT).
