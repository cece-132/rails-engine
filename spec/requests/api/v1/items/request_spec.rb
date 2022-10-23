require 'rails_helper'

RSpec.describe "Items API" do
  describe 'index' do
    it 'retuns all Items' do
      merchant = create(:merchant)
      create_list(:item, 5, merchant_id: merchant.id)

      get "/api/v1/items"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a Hash
      expect(items).to have_key(:data)
      expect(items[:data]).to be_a Array

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

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
  end

  describe 'show' do
    it 'returns 1 item' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item_1.id}"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to be_a Hash
      expect(item).to have_key(:data)
      expect(item[:data]).to have_key(:id)
      expect(item[:data]).to have_key(:type)
      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes]).to have_key(:merchant_id)
    end
  end

  describe 'create' do
    it 'can create an item' do

      item_params = ( {
        name: "Widget",
        description: "High quality widget",
        unit_price: 100.99,
        merchant_id: create(:merchant).id
      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to be_a Hash
      expect(item).to have_key(:data)
      expect(item[:data]).to have_key(:id)
      expect(item[:data]).to have_key(:type)
      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes]).to have_key(:merchant_id)
    end
  end

  describe 'Update' do
    it 'can update and item' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      previous_name = Item.last.name
      item_params = { name: "New Name" }
      headers = {"CONTENT_TYPE" => "application/json"}

      put "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})

      item = JSON.parse(response.body, symbolize_names: true)
      updated_item = Item.last
      
      expect(response).to be_successful
      expect(updated_item.name).to_not eq previous_name
      expect(updated_item.name).to eq "New Name"
    end

    it 'returns 404 when datatype incorrect' do
      item = create(:item)
  
      item_params = { name: "" }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      put "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})

      expect(response.status).to eq(404)
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response[:error]).to eq('Unsuccessful update' )
      expect(Item.last.name).to_not eq("")
    end

    it 'returns 404 if item not found' do
      item = create(:item)
  
      item_params = { name: "New Name" }
      headers = {"CONTENT_TYPE" => "application/json"}

      put "/api/v1/items/690927", headers: headers, params: JSON.generate({item: item_params})

      expect(response.status).to eq(404)

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response[:error]).to eq('No item found' )
    end
  end
end