class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.all
    render json: ItemSerializer.format_items(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.format_item(item)
  end

  def create
    if Item.create(item_params).valid?
      render json: ItemSerializer.format_item(Item.create(item_params)), status: 201
    else
      render status: :not_found
    end
  end

  def update
    if params[:item][:merchant_id].present?
      if Merchant.exists?(params[:item][:merchant_id])
        render json: ItemSerializer.format_item(Item.update(params[:id], item_params))
      else
        render status: :not_found
      end
    else
      render json: ItemSerializer.format_item(Item.update(params[:id], item_params))
    end
  end

  def destroy
    Item.destroy(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end