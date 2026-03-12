require "rails_helper"

describe "Previewing components", type: :system do
  it "renders component previews" do
    visit "/preview/"

    expect(page).to have_text("Component")
  end

  it "checks GDS Transport font is available", :js do
    visit "/preview/"
    font_loaded = evaluate_script("document.fonts.check('12px GDS Transport')")

    expect(font_loaded).to be true
  end
end
