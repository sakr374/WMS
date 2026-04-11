class ApplicationController < ActionController::API
    before_action :extract_token!
  
    private
  
    def extract_token!
      header = request.headers['Authorization']
      @current_token = header.split(' ').last if header
  
      unless @current_token
        render json: { error: 'Missing WMS Token' }, status: :unauthorized
      end
    end
  end