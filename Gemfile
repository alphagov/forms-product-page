source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: ".ruby-version"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.0"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.5"

# Alpine requires these to build the assets
gem "tzinfo"
gem "tzinfo-data"

# For compiling our frontend assets
gem "vite_rails", "~> 3.0"

# For structured logging
gem "lograge", "~> 0.14"

gem "config"

# Use Sentry (https://sentry.io/for/ruby/?platform=sentry.ruby.rails#)
gem "sentry-rails"
gem "sentry-ruby"

# For GOV.UK branding
gem "govuk-components"
gem "govuk_design_system_formbuilder"

# For pausing pipelines
gem "aws-sdk-codepipeline", "~> 1.90"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails", "~> 7.1.0"
  gem "rubocop-govuk", require: false

  # For security auditing gem vulnerabilities. RUN IN CI
  gem "bundler-audit", "~> 0.9.2"

  # For detecting security vulnerabilities in Ruby on Rails applications via static analysis.
  gem "brakeman", "~> 6.2.2"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"

  gem "webmock"

  # Code coverage reporter
  gem "simplecov", "~> 0.22.0", require: false
end
