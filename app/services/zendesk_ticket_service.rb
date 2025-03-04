class ZendeskTicketService
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
    basic_encoded = [ "#{Settings.zendesk.api_user}/token:#{Settings.zendesk.api_token}" ].pack("m0")
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
      raise "Creating Zendesk ticket failed: #{response.code}"
    end
  end
end
