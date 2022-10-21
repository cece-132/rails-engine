class ItemMerchantSerializer
  
  def self.new_merchant(item, merchant)
    { data:
      { id: "#{item.id}",
        type: item.class.to_s.downcase,
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            merchant_id: item.merchant_id
          }
      },
      relationships: 
        { id: "#{merchant.id}",
          type: merchant.class.to_s.downcase,
            attributes: { 
              name: merchant.name
            }
        }
    }
  end
end