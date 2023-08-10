class HeartbeatController < ApplicationController
  def ping
    render(body: "PONG")
  end
end
