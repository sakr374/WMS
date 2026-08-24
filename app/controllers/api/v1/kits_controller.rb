class Api::V1::KitsController < ApplicationController
  def index
    result = WmsClient.fetch(request.fullpath, @current_token)
    raw_data = result[:body]

    if result[:status] == 200 && raw_data['records']
      Thread.new do
        Rails.application.executor.wrap do
          DbSyncer.sync_inventory(raw_data['records'], raw_data['_stock'])
        end
      end
    end

    render json: raw_data, status: result[:status]
  end
  
  def show
    result = WmsClient.fetch(request.fullpath, @current_token)
    render json: result[:body], status: result[:status]
  end
end
