require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#page_title" do
    it "returns the title with separator and default suffix" do
      helper.content_for(:title, "Test Title")
      expect(helper.page_title).to eq("Test Title – GOV.UK Forms")
    end

    it "returns only the default suffix if title is not set" do
      expect(helper.page_title).to eq("GOV.UK Forms")
    end
  end

  describe "#set_page_title" do
    it "sets the page title" do
      helper.set_page_title("New Title")
      expect(helper.content_for(:title)).to eq("New Title")
    end
  end

  describe "#page_description" do
    it "returns the meta tag with description if description is set" do
      helper.content_for(:description, "Test Description")
      expect(helper.page_description).to eq('<meta name="description" content="Test Description">')
    end

    it "returns nil if description is not set" do
      expect(helper.page_description).to be_nil
    end
  end

  describe "#set_page_description" do
    it "sets the page description" do
      helper.set_page_description("New Description")
      expect(helper.content_for(:description)).to eq("New Description")
    end
  end

  describe "#page_robots" do
    it "returns the meta tag with robots directive if robots is set" do
      helper.content_for(:robots, "test")
      expect(helper.page_robots).to eq('<meta name="robots" content="test">')
    end

    it "returns nil if robots is not set" do
      expect(helper.page_robots).to be_nil
    end
  end

  describe "#set_page_robots" do
    it "sets the robots directive for the page" do
      helper.set_page_robots("noindex")
      expect(helper.content_for(:robots)).to eq("noindex")
    end
  end

  describe "#meta_items" do
    it "returns a hash containing the meta links" do
      expect(helper.meta_items).to eq({
        t("footer.meta_items.accessibility") => "/accessibility",
        t("footer.meta_items.cookies") => "/cookies",
        t("footer.meta_items.privacy") => "/privacy",
        t("footer.meta_items.terms_of_use") => "/terms-of-use",
      })
    end
  end
end
