RSpec.configure do |config|
  config.before(:example, type: :system) do
    driven_by(Settings.show_browser_during_tests ? :selenium : :selenium_chrome_headless)
  end
end
