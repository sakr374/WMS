class Api::ReadinessController < ApplicationController
    def index
      # Test the token against the real WMS
      data = WmsClient.fetch('/api/readiness', @current_token)
      
      if data[:error]
        render json: data, status: :bad_gateway
      else
        # Inject our Rails flag so the UI knows it hit the secure backend
        data['server'] = "#{data['server']} (Proxied via Secure Rails)"
        render json: data, status: :ok
      end
    end
  end