# frozen_string_literal: true

# spec/views/layouts/application.html.erb_spec.rb

require "rails_helper"

RSpec.describe "layouts/application" do
  it "renders the layout with a link to sign in to forms-admin in the header" do
    render

    expect(rendered).to have_link("Sign in", href: Settings.forms_admin.base_url)
  end
end
