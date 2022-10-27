require 'rails_helper'

RSpec.describe "Items API" do
  describe 'Find One Item' do
    it 'returns the item in the search in alpha order' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Alpha" ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find?name=eTa"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

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

    it 'it returns empty it no item found' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Alpha" ))
      item_3 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find?name=CdF"

      expect(response).to have_http_status(400)

    end
  end

  describe 'find items matches price' do
    it 'items between the max and min price' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Zeta", unit_price: 200 ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Alpha", unit_price: 150 ))
      item_3 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Theta", unit_price: 75 ))

      get "/api/v1/items/find?max_price=150&min_price=50"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key(:data)
      expect(items[:data]).to be_a Array
      expect(items[:data].count).to eq 2
    end 
    
    it 'returns items where unit_price is >= min_price' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Zeta", unit_price: 200 ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Alpha", unit_price: 20 ))
      item_3 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Theta", unit_price: 75 ))

      get "/api/v1/items/find?min_price=-50"

      expect(response).to have_http_status(400)

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key(:data)
      expect(items[:data]).to be_a Hash
    end

    it 'returns items where unit_price is <= max_price' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Zeta", unit_price: 200 ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Alpha", unit_price: 20 ))
      item_3 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Theta", unit_price: 75 ))

      get "/api/v1/items/find?max_price=50"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key(:data)
      expect(items[:data]).to be_a Array
      expect(items[:data].count).to eq 1
    end
  end
end