require 'rails_helper'

RSpec.describe 'Items search' do
  describe 'find' do
    it 'find a single item where the name includes search' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Alpha" ))
      item_3 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find?name=eTa"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to be_a Hash
      expect(item).to have_key(:data)
      expect(item[:data]).to be_a Hash
      expect(item[:data][:id]).to eq "#{item_1.id}"
    end

    it 'finds a single item where the min price is in search' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, unit_price: 100.5, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, unit_price: 50.5, merchant: merchant, name: "Alpha" ))
      item_3 = merchant.items.create(attributes_for(:item, unit_price: 75.5, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find?min_price=65"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to be_a Hash
      expect(item).to have_key(:data)
      expect(item[:data]).to be_a Hash
      expect(item[:data][:id]).to eq "#{item_3.id}"
    end

    it 'finds a single item where the max price is in search' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, unit_price: 100.5, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, unit_price: 50.5, merchant: merchant, name: "Alpha" ))
      item_3 = merchant.items.create(attributes_for(:item, unit_price: 75.5, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find?max_price=120"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to be_a Hash
      expect(item).to have_key(:data)
      expect(item[:data]).to be_a Hash
      expect(item[:data][:id]).to eq "#{item_2.id}"
    end

    it 'finds a single item between the max and min price is in search' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, unit_price: 100.5, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, unit_price: 50.5, merchant: merchant, name: "Alpha" ))
      item_3 = merchant.items.create(attributes_for(:item, unit_price: 75.5, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find?max_price=120&min_price=80"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to be_a Hash
      expect(item).to have_key(:data)
      expect(item[:data]).to be_a Hash
      expect(item[:data][:id]).to eq "#{item_1.id}"
    end
  end

  describe 'find_all' do
    it 'find all the items in search for name' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Alpha" ))
      item_3 = merchant.items.create(attributes_for(:item, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find_all?name=eTa"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a Hash
      expect(items).to have_key(:data)
      expect(items[:data]).to be_a Array
      expect(items[:data].count).to eq 2
    end

    it 'find all the items in search for min_price' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, unit_price: 100.5, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, unit_price: 50.5, merchant: merchant, name: "Alpha" ))
      item_3 = merchant.items.create(attributes_for(:item, unit_price: 75.5, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find_all?min_price=70"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a Hash
      expect(items).to have_key(:data)
      expect(items[:data]).to be_a Array
      expect(items[:data].count).to eq 2
    end

    it 'find all the items in search for max_price' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, unit_price: 100.5, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, unit_price: 50.5, merchant: merchant, name: "Alpha" ))
      item_3 = merchant.items.create(attributes_for(:item, unit_price: 75.5, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find_all?max_price=70"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a Hash
      expect(items).to have_key(:data)
      expect(items[:data]).to be_a Array
      expect(items[:data].count).to eq 1
    end

    it 'find all the items in search between max_price and min_price' do
      merchant = create(:merchant)
      item_1 = merchant.items.create(attributes_for(:item, unit_price: 100.5, merchant: merchant, name: "Zeta" ))
      item_2 = merchant.items.create(attributes_for(:item, unit_price: 50.5, merchant: merchant, name: "Alpha" ))
      item_3 = merchant.items.create(attributes_for(:item, unit_price: 75.5, merchant: merchant, name: "Theta" ))

      get "/api/v1/items/find_all?max_price=80&min_price=70"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to be_a Hash
      expect(items).to have_key(:data)
      expect(items[:data]).to be_a Array
      expect(items[:data].count).to eq 1
    end
  end
end