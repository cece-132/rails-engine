require 'rails_helper'

RSpec.describe "Items API" do
  
  describe 'sends a list of items' do
    it 'sends a list of items' do
      create_list(:merchant, 3)
      create_list(:item, 10)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq 10
      expect(items).to be_a Hash
      expect(items).to have_key(:data)
      expect(items[:data]).to be_a Array

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:attributes)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    it 'returns an array even if empty' do
      create_list(:merchant, 3)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key(:data)
      expect(items[:data].count).to eq 0
      expect(items[:data]).to be_a Array
    end
  end

  describe 'send a single item' do
    it 'sends the item w/ id' do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to be_a Hash
      expect(item).to have_key(:data)
      expect(item[:data]).to be_a Hash

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_a(String)

      expect(item[:data]).to have_key(:attributes)

      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)

      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
    end

    it 'sad path, bad integer id returns 404'
    it 'edge case, string id returns 404'

  end

  describe 'item creation' do
    it 'can create an object' do
      merchant = create(:merchant)
      create_list(:item, 3)

      item_params = ( {
        name: "Widget",
        description: "High quality widget",
        unit_price: 100.99,
        merchant_id: merchant.id
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last

      expect(response).to be_successful

      expect(created_item[:name]).to eq(item_params[:name])
      expect(created_item[:description]).to eq(item_params[:description])
      expect(created_item[:unit_price]).to eq(item_params[:unit_price])
      expect(created_item[:merchant_id]).to eq(item_params[:merchant_id])
    end

    it 'returns an error if an attribute is missing' do
      merchant = create(:merchant)
      create_list(:item, 3)

      item_params = ( {
        name: "Widget",
        description: "High quality widget",
        merchant_id: merchant.id
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last

      expect(response).to_not be_successful
      expect(response.status).to eq 404
    end

    it 'ignores attributes that are not allowed' do
      merchant = create(:merchant)
      create_list(:item, 3)

      item_params = ( {
        name: "Widget",
        description: "High quality widget",
        unit_price: 100.99,
        merchant_id: merchant.id,
        status: 'pending'
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq 201
      expect(item).to_not have_key(:status)
      expect(item[:data]).to_not have_key(:status)
      expect(item[:data][:attributes]).to_not have_key(:status)
    end
  end

  describe 'Item update' do
    it 'updates a found item'
    it 'returns a 404 error when item not found'
  end

end