class Api::BootController < ApplicationController
  def index
    result = WmsClient.fetch('/api/boot', @current_token)
    render json: result[:body], status: result[:status]
  end
end
