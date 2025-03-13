module PerformanceData
  extend ActiveSupport::Concern

  def fetch_data
    @performance_data = YAML.load_file(Rails.root.join("config/performance_metrics.yml"), permitted_classes: [Date])["performance_metrics"]
    @last_updated = @performance_data.delete("last_updated").to_date.to_formatted_s(:rfc822)
  end
end
