class Api::V1::KitsController < ApplicationController
    def index
      # Fetch real kits data from 3PL WMS
      raw_data = WmsClient.fetch(request.fullpath, @current_token)
  
      # Sync to our PostgreSQL database securely in the background
      if raw_data['records']
        Thread.new do
          Rails.application.executor.wrap do
            DbSyncer.sync_inventory(raw_data['records'], raw_data['_stock'])
          end
        end
      end
  
      # Return exact data to frontend
      render json: raw_data
    end
  end