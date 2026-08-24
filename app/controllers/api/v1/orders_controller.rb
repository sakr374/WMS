class Api::V1::OrdersController < ApplicationController
  def index
    result = WmsClient.fetch(request.fullpath, @current_token)
    raw_data = result[:body]

    if result[:status] == 200 && raw_data['records']
      Thread.new do
        Rails.application.executor.wrap do
          DbSyncer.sync_orders(raw_data['records'])
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
