require "rails_helper"

describe "Previewing components", type: :system do
  it "checks GDS Transport font is available", :js do
    visit "/preview/"
    font_loaded = evaluate_script("document.fonts.check('12px GDS Transport')")

    expect(font_loaded).to be true
  end
end
