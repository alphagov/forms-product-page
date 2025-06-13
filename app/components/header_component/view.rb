module HeaderComponent
  class View < ViewComponent::Base
    attr_accessor :phase_name

    def initialize(phase_name: nil)
      super
      @phase_name = phase_name
    end

    def call
      govuk_header(homepage_url:, classes: "govuk-header--full-width-border") do |header|
        header.with_product_name(name: "Forms")
      end
    end

  private

    def homepage_url
      root_path
    end
  end
end
