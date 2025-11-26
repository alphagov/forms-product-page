class JsonSubmissionsController < ApplicationController
  def schema_v1
    render formats: :json
  end
end
