require "rails_helper"

describe "pages/get_started.html.markerb", type: :view do
  it "displays a prominent start button linking to the forms-admin sign-up page" do
    render template: "pages/get_started"

    expect(rendered).to have_link(
      "Create an account",
      href: "http://localhost:3000/sign-up",
      class: "govuk-button govuk-button--start",
    )
  end
end
