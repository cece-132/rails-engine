require 'rails_helper'

RSpec.describe "Items API" do
  describe 'Find One Item' do
    it 'returns the first item in the search in alpha order' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Alpha" ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find?name=eTa"

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

    it 'it returns empty it no item found' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Alpha" ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find?name=CdF"

      expect(response).to_not be_successful

      # item = JSON.parse(response.body, symbolize_names: true)
    end
  end
end