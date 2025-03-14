class PerformanceController < ApplicationController
  include PerformanceData
  def index
    fetch_data

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @performance_data, status: :ok }
    end
  end
end
