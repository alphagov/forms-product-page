require "rails_helper"

describe "pages/using_forms/get_started.html.md", type: :view do
  it "displays a prominent start button linking to the forms-admin sign-up page" do
    render template: "pages/using_forms/get_started"

    expect(rendered).to have_link(
      "Create an account",
      href: "http://localhost:3000/sign-up",
      class: "govuk-button govuk-button--start",
    )
  end
end
