class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.all
    render json: ItemSerializer.format_items(items)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.format_item(Item.find(params[:id]))
    else
      render json: { data: {}, error: 'error' }, status: 404
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.format_item(item), status: 201
    else
      render json: { data: {}, error: 'error' }, status: 400
    end
  end

  def update
    if params[:item][:merchant_id].present?
      if Merchant.exists?(params[:item][:merchant_id])
        render json: ItemSerializer.format_item(Item.update(params[:id], item_params))
      else
        render json: { data: {}, error: 'error' }, status: 400
      end
    else
      render json: ItemSerializer.format_item(Item.update(params[:id], item_params))
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