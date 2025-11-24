class ZendeskTicketService
  class CreateFailedError < StandardError; end

  class << self
    def create!(...)
      new.create!(...)
    end
  end

  def create!(comment:, **params)
    ticket_json = { ticket: {
      comment:,
      **params,
      **Settings.zendesk.defaults,
    } }.to_json

    post_json!("https://#{subdomain}.zendesk.com/api/v2/tickets.json", ticket_json, headers:)
  end

private

  def authorization
    basic_encoded = ["#{Settings.zendesk.api_user}/token:#{Settings.zendesk.api_token}"].pack("m0")
    "Basic #{basic_encoded}"
  end

  def headers
    {
      "Authorization" => authorization,
      "Content-Type" => "application/json",
    }
  end

  def subdomain
    Settings.zendesk.subdomain
  end

  def post_json!(url, json_data, headers: nil)
    uri = URI.parse(url)
    response = Net::HTTP.post(uri, json_data, headers)
    if response.is_a? Net::HTTPSuccess
      JSON.parse(response.body)
    else
      Sentry.with_scope do |scope|
        scope.set_extra(:zendesk_error_message, JSON.parse(response.body)&.[]("error")) if response.body
        scope.set_extra(:zendesk_response_code, response.code)
        exception = CreateFailedError.new("Creating Zendesk ticket failed: #{response.code}")
        Sentry.capture_exception(exception)
        raise exception
      end
    end
  end
end
