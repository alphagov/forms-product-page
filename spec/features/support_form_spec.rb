require "rails_helper"

describe "Support form", type: :system do
  before do
    stub_request(:post, "https://changeme.zendesk.com/api/v2/tickets.json")
      .to_return { |request| { status: 201, body: request.body } }
  end

  it "asks users what they need help with" do
    visit "/support"

    expect(page).to have_text "Support"
    expect(page).to have_text "What do you need help with?"
    expect(page).to have_field("support_form[i_need_help_with]", type: :radio, visible: :all).exactly(3).times
  end

  scenario "a civil servant needs help using GOV.UK Forms" do
    visit "/support"

    choose "I work in a government service team and need help using GOV.UK Forms", visible: :all
    click_button "Continue"

    expect(page).to have_text "Help using GOV.UK Forms"
    fill_in "Your message", with: "I need help using GOV.UK Forms"
    fill_in "Your name", with: "Test User"
    fill_in "Your email address", with: "test@example.com"
    click_button "Send"

    expect(page).to have_text "Message sent"
  end

  scenario "a civil servant has a question about GOV.UK Forms" do
    visit "/support"

    choose "I work in a government service team and have a question about GOV.UK Forms", visible: :all
    click_button "Continue"

    expect(page).to have_text "Question about GOV.UK Forms"
    fill_in "Your question", with: "I have a question about GOV.UK Forms"
    fill_in "Your name", with: "Test User"
    fill_in "Your email address", with: "test@example.com"
    click_button "Send"

    expect(page).to have_text "Message sent"
  end

  scenario "a member of the public is looking for help with a form" do
    visit "/support"

    choose "I’m a member of the public with a question about a government form or service", visible: :all
    click_button "Continue"

    expect(page.current_url).to eq "https://www.gov.uk/contact"
    expect(page).to have_text "Find contact details for services"
  end
end
