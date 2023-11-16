require "rails_helper"

describe "pages/get_started.html.erb", type: :view do
  before do
    allow(Settings.forms_admin).to receive(:base_url).and_return("forms-admin.test")

    render template: "pages/get_started"
  end

  it "has a call to action encouraging users to create an account in forms-admin" do
    expect(rendered).to have_selector(".govuk-button--start") do |start_button|
      expect(start_button).to match_selector(
        :link,
        "Create a trial account",
        href: "forms-admin.test/sign-up",
      )
    end
  end
end
