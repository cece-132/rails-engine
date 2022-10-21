class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.all
    render json: ItemSerializer.new(items)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render json: { data: {}, error: 'error' }, status: 404
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item)
    end
  end

  def update
    if params[:item][:merchant_id].present?
      if Merchant.exists?(params[:item][:merchant_id])
        render json: ItemSerializer.new(Item.update(params[:id], item_params))
      else
        render json: { data: {}, error: 'error' }, status: 404
      end
    else
      render json: ItemSerializer.new(Item.update(params[:id], item_params))
    end
  end

  def destroy
    if Item.exists?(params[:id])
      Item.destroy(params[:id])
    else
      render status: 404
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end