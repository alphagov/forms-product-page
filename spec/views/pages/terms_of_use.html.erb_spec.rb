require "rails_helper"

describe "pages/terms_of_use.html.erb", type: :view do
  before do
    render template: "pages/terms_of_use"
  end

  it "renders the terms of use" do
    expect(rendered).to have_text(t("terms_of_use.summary.section_1"))
    expect(rendered).to have_text(t("terms_of_use.security.heading"))
    expect(rendered).to have_text(t("terms_of_use.data_protection.heading"))
    expect(rendered).to have_text(t("terms_of_use.accessibility.heading"))
    expect(rendered).to have_text(t("terms_of_use.service_standards.heading"))
    expect(rendered).to have_text(t("terms_of_use.changes.heading"))
  end
end
