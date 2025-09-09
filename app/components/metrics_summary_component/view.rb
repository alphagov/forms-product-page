module MetricsSummaryComponent
  class View < ApplicationComponent
    attr_reader :error_message, :metrics

    def initialize(metrics)
      super()
      @metrics = metrics

      if metrics.blank?
        @error_message = I18n.t("metrics_summary.errors.no_data")
      end
    end
  end
end
