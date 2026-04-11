class Api::V1::OrdersController < ApplicationController
    def index
      raw_data = WmsClient.fetch(request.fullpath, @current_token)
  
      if raw_data['records']
        Thread.new do
          Rails.application.executor.wrap do
            DbSyncer.sync_orders(raw_data['records'])
          end
        end
      end
  
      render json: raw_data
    end
  
    def show
      render json: WmsClient.fetch(request.fullpath, @current_token)
    end
  end