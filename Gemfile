source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.4"

# Alpine requires these to build the assets
gem "tzinfo"
gem "tzinfo-data"

# For compiling our frontend assets
gem "vite_rails", "~> 3.0"

# For structured logging
gem "lograge", "~> 0.13"

gem "config", "~> 4.2"

# Use Sentry (https://sentry.io/for/ruby/?platform=sentry.ruby.rails#)
gem "sentry-rails", "~> 5.12"
gem "sentry-ruby", "~> 5.12"

# For GOV.UK branding
gem "govuk-components", "~> 4.1.0"
gem "govuk_design_system_formbuilder", "~> 4.1.1"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails", "~> 6.0.0"
  gem "rubocop-govuk", require: false

  # For security auditing gem vulnerabilities. RUN IN CI
  gem "bundler-audit", "~> 0.9.0"

  # For detecting security vulnerabilities in Ruby on Rails applications via static analysis.
  gem "brakeman", "~> 6.0.1"
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
end
