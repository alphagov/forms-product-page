module MetricsSummaryComponent
  class View < ViewComponent::Base
    attr_reader :error_message, :label, :number

    def initialize(label:, number:)
      super
      @label = label.html_safe
      @number = number

      if number.nil?
        @error_message = I18n.t("metrics_summary.errors.no_data")
      end
    end
  end
end
