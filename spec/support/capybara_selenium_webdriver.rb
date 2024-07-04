# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:example, type: :system) do
    driven_by(Settings.show_browser_during_tests ? :selenium : :selenium_chrome_headless)
  end

  config.before(:example, js: false) do
    Capybara.current_driver = :rack_test
  end
end
