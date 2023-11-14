Govuk::Components.configure do |config|
  # Fix default header ARIA labels to match GOV.UK Frontend 4.x
  # TODO: Remove these lines when a fix for x-govuk/govuk-components#460 has been released
  config.default_header_navigation_label = "Menu"
  config.default_header_menu_button_label = "Show or hide menu"
end
