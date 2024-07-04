# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Mailing list", type: :request do
  it "redirects users to the mailing list subscription page" do
    get mailing_list_path

    expect(response).to redirect_to %r{https://service.*.list-manage.com/subscribe}
  end
end
