class Api::V1::InventoriesController < ApplicationController
  def index
    result = WmsClient.fetch(request.fullpath, @current_token)
    raw_data = result[:body]

    # Only sync to DB if the API returned a 200 OK
    if result[:status] == 200 && raw_data['records']
      Thread.new do
        Rails.application.executor.wrap do
          DbSyncer.sync_inventory(raw_data['records'], raw_data['_stock'])
        end
      end
    end

    # Pass the actual status code back to the frontend!
    render json: raw_data, status: result[:status]
  end

  def show
    result = WmsClient.fetch(request.fullpath, @current_token)
    render json: result[:body], status: result[:status]
  end
end