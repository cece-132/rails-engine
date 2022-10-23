class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.all
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    item = Item.new(item_params)
    if item.save
      
      render json: ItemSerializer.new(item), status: 201
    else
      render status: 404
    end
  end

  def update
    if Item.exists?(params[:id])
      item = Item.find(params[:id])
      if item.update(item_params)
        render json: ItemSerializer.new(item), status: 202
      else
        render json: { error: 'Unsuccessful update' }, status: 404
      end
    else
      render json: { error: 'No item found' }, status: 404
    end
  end

  def destroy
    if Item.exists?(params[:id])
      Item.destroy(params[:id])
    else
      render json: { error: 'No item found' }, status: 404
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end