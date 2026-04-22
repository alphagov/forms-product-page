module SubNavigationComponent
  class View < ApplicationComponent
    renders_one :navigation_list, "SubNavigationComponent::SubNavigationListComponent::View"

    attr_reader :aria_label_text

    def initialize(navigation_items: [], current_path: nil, aria_label: "Sub menu")
      @aria_label_text = aria_label

      if navigation_items.any?
        with_navigation_list(navigation_items:, current_path:, with_separator: true)
      end

      super()
    end

    def call
      return unless navigation_list?

      tag.nav(navigation_list, aria: { label: aria_label_text }, **html_attributes)
    end

  private

    def html_attributes
      {
        class: %w[
          app-sub-navigation
        ],
      }
    end
  end
end
