# frozen_string_literal: true

class JsonLogFormatter < ActiveSupport::Logger::Formatter
  def call(severity, timestamp, _progname, message)
    log_event = {
      level: severity,
      time: timestamp
    }

    if json?(message)
      log_event.merge!(JSON.parse(message))
    else
      log_event[:message] = message
    end

    "#{log_event.to_json}\n"
  end

  def json?(message)
    result = JSON.parse(message)
    result.is_a?(Hash) || result.is_a?(Array)
  rescue JSON::ParserError, TypeError
    false
  end
end
