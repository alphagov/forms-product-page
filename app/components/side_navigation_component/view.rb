module SideNavigationComponent
  class View < ApplicationComponent
    attr_reader :navigation_items

    def initialize(navigation_items:)
      super()
      @navigation_items = navigation_items
    end
  end
end
