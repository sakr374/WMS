class WmsClient
  BASE_URL = ENV.fetch('WMS_BASE_URL', 'https://scanwms.my3pl.net')

  def self.fetch(path, token)
    response = Faraday.get("#{BASE_URL}#{path}") do |req|
      req.headers['Authorization'] = "Bearer #{token}"
      req.headers['Accept'] = 'application/json'
      
      # INCREASE THIS TIMEOUT TO 30 SECONDS
      req.options.timeout = 30 
    end

    {
      status: response.status,
      body: JSON.parse(response.body)
    }
  rescue Faraday::Error => e
    { status: 502, body: { error: "WMS Connection Failed: #{e.message}" } }
  end
end