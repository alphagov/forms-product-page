module Lograge
  class CustomOptions
    def self.call(event)
      {}.tap do |h|
        h[:host] = event.payload[:host]
        h[:user_ip] = event.payload[:user_ip]
        h[:request_id] = event.payload[:request_id]
        h[:exception] = event.payload[:exception] if event.payload[:exception]
        h[:trace_id] = event.payload[:trace_id] if event.payload[:trace_id]
      end
    end
  end
end
