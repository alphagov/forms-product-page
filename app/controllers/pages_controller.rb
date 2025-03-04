class PagesController < ApplicationController
  def index
    @performance_data = YAML.load_file(Rails.root.join("config/performance_metrics.yml"))["performance_metrics"]
    @last_updated = File.mtime(Rails.root.join("config/performance_metrics.yml").to_s).to_date.to_formatted_s(:rfc822)
    render(layout: "layouts/homepage")
  end

  def get_started; end
  def features; end
  def create_good_forms; end
  def accessibility; end
  def cookies; end
  def privacy; end
  def terms_of_use; end
end
