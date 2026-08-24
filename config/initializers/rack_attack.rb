class Rack::Attack
    # Throttle all requests by IP (e.g., 100 requests per minute)
    throttle('req/ip', limit: 5000, period: 5.minute) do |req|
      req.ip
    end
  
    # Strictly throttle login/auth attempts
    throttle('auth/ip', limit: 5, period: 20.seconds) do |req|
      if req.path == '/api/auth' && req.post?
        req.ip
      end
    end
  end
