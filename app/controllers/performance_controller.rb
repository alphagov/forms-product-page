class PerformanceController < ApplicationController
  def index
    @performance_data = YAML.load_file(Rails.root.join("config/performance_metrics.yml"))["performance_metrics"]
    @last_updated = File.mtime(Rails.root.join("config/performance_metrics.yml").to_s).to_date.to_formatted_s(:rfc822)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @performance_data, status: :ok }
    end
  end
end
