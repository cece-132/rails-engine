class Api::V1::MerchantItemsController < ApplicationController
  def index
    if Merchant.exists?(params[:id])
      items = Merchant.find(params[:id]).items
      render json: ItemSerializer.new(items), status: 200
    else
      render json: { error: 'Merchant Items not found' }, status: 404
    end
  end
end