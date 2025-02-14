class PerformanceController < ApplicationController
  def index
    @performance_metrics = YAML.load_file(Rails.root.join("config/performance_metrics.yml"))["performance_metrics"]
    Rails.logger.debug "Performance metrics: #{@performance_metrics}"
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @performance_metrics, status: :ok }
    end
  end
end
