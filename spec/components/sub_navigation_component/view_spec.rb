require "rails_helper"

RSpec.describe SubNavigationComponent::View, type: :component do
  subject(:sub_navigation_component) do
    described_class.new(navigation_items:, current_path:)
  end

  let(:navigation_items) { [] }
  let(:current_path) { nil }

  before do
    render_inline sub_navigation_component
  end

  describe "without navigation items" do
    it "does not render the component" do
      expect(page).not_to have_element
    end
  end

  describe "with navigation items" do
    let(:navigation_items) do
      [
        { text: "Get started", href: "/get-started" },
        { text: "About", href: "/about" },
      ]
    end

    it "renders the component" do
      expect(page).to have_css "nav.app-sub-navigation", count: 1 do |nav|
        expect(nav).to have_css "ul.app-sub-navigation__list", count: 1 do |ul|
          expect(ul).to have_css "li.app-sub-navigation__item", count: 2
        end
      end
    end

    it "has an accessible title" do
      sub_navigation = page.find("nav.app-sub-navigation")
      expect(sub_navigation["aria-label"]).to eq "Sub menu"
    end

    context "when given an aria label" do
      subject(:sub_navigation_component) do
        described_class.new(navigation_items:, current_path:, aria_label: "Pages")
      end

      it "has an accessible title" do
        sub_navigation = page.find("nav.app-sub-navigation")
        expect(sub_navigation["aria-label"]).to eq "Pages"
      end
    end

    it "renders each navigation item as a link" do
      links = page.find_all ".app-sub-navigation__list .app-sub-navigation__link"

      expect(links.map { |a| { text: a.text, href: a[:href] } })
        .to eq(navigation_items)
    end

    describe "when one of the items is marked as the current page" do
      let(:navigation_items) do
        [
          { text: "Get started", href: "/get-started" },
          { text: "About", href: "/about", current: true },
        ]
      end

      it "renders the current navigation item with the active style" do
        expect(page).to have_css "nav ul li.app-sub-navigation__item--active", count: 1 do |item|
          expect(item).to have_element :strong do |strong|
            expect(strong).to have_link "About", href: "/about"
          end
        end
      end

      it "indicates which item has the active style to assistive technology" do
        expect(page).to have_css 'nav ul li a.app-sub-navigation__link[aria-current="page"]', count: 1 do |item|
          expect(item).to have_ancestor "li.app-sub-navigation__item--active"
        end
      end
    end

    describe "when one of the items links to the current page" do
      let(:current_path) { "/get-started" }

      it "renders the navigation item with the active style" do
        expect(page).to have_css "nav ul li.app-sub-navigation__item--active", count: 1 do |item|
          expect(item).to have_element :strong do |strong|
            expect(strong).to have_link "Get started", href: "/get-started"
          end
        end
      end

      it "indicates which item has the active style to assistive technology" do
        expect(page).to have_css 'nav ul li a.app-sub-navigation__link[aria-current="page"]', count: 1 do |item|
          expect(item).to have_ancestor "li.app-sub-navigation__item--active"
        end
      end
    end
  end

  describe "with nested navigation items" do
    let(:navigation_items) do
      [
        { text: "Get started", href: "/get-started" },
        {
          current: true,
          text: "About",
          href: "/about",
          navigation_items: [
            { text: "Features", href: "/features" },
            { text: "Forthcoming features", href: "/forthcoming-features" },
          ],
        },
      ]
    end

    it "nests the nested navigation items" do
      items = page.find_all "nav > ul > .app-sub-navigation__item"
      expect(items.map do |item|
        nested_links = item.find_all(".app-sub-navigation__list .app-sub-navigation__link")
        navigation_items = nested_links.map { |a| { text: a.text, href: a[:href] } }
        a = item.first("a")
        { text: a.text, href: a[:href], navigation_items: }.compact_blank
      end)
        .to eq(navigation_items.map { it.except(:current) })
    end

    describe "when a nested navigation item links to the current page" do
      let(:navigation_items) do
        [
          { text: "Get started", href: "/get-started" },
          {
            text: "About",
            href: "/about",
            navigation_items: [
              { text: "Features", href: "/features" },
              { text: "Forthcoming features", href: "/forthcoming-features" },
            ],
          },
        ]
      end
      let(:current_path) { "/forthcoming-features" }

      it "renders the nested item with the active style" do
        expect(page).to have_css "nav ul li ul li.app-sub-navigation__item--active", count: 1 do |item|
          expect(item).to have_element :strong do |strong|
            expect(strong).to have_link "Forthcoming features", href: "/forthcoming-features"
          end
        end
      end

      it "indicates which item has the active style to assistive technology" do
        expect(page).to have_css 'nav ul li a.app-sub-navigation__link[aria-current="page"]', count: 1 do |item|
          expect(item).to have_ancestor "li.app-sub-navigation__item--active"
        end
      end
    end

    describe "when a nested navigation item is marked as current" do
      let(:navigation_items) do
        [
          { text: "Get started", href: "/get-started" },
          {
            text: "About",
            href: "/about",
            navigation_items: [
              { text: "Features", href: "/features", current: true },
              { text: "Forthcoming features", href: "/forthcoming-features" },
            ],
          },
        ]
      end

      it "renders the nested item with the active style" do
        expect(page).to have_css "nav ul li ul li.app-sub-navigation__item--active", count: 1 do |item|
          expect(item).to have_element :strong do |strong|
            expect(strong).to have_link "Features", href: "/features"
          end
        end
      end

      it "indicates which item has the active style to assistive technology" do
        expect(page).to have_css 'nav ul li a.app-sub-navigation__link[aria-current="page"]', count: 1 do |item|
          expect(item).to have_ancestor "li.app-sub-navigation__item--active"
        end
      end
    end

    describe "when none of the items in a nested navigation list is active" do
      let(:navigation_items) do
        [
          { text: "Get started", href: "/get-started" },
          {
            text: "About",
            href: "/about",
            navigation_items: [
              { text: "Features", href: "/features" },
              { text: "Forthcoming features", href: "/forthcoming-features" },
            ],
          },
        ]
      end
      let(:current_path) { "/get-started" }

      it "does not render the nested navigation list" do
        links = page.find_all ".app-sub-navigation__list .app-sub-navigation__link"

        expect(links.map { |a| { text: a.text, href: a[:href] } })
          .to eq([
            { text: "Get started", href: "/get-started" },
            { text: "About", href: "/about" },
          ])
      end
    end
  end
end
