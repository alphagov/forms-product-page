class PerformanceController < ApplicationController
  def index
    @performance_data = YAML.load_file(Rails.root.join("config/performance_metrics.yml"))["performance_metrics"]
    Rails.logger.debug "Performance metrics: #{@performance_data}"
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @performance_data, status: :ok }
    end
  end
end
