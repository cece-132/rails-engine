class ItemSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :unit_price, :merchant_id
end
  # def self.new(items)
  #     { data: items.map do |item|
  #         { id: "#{item.id}",
  #           type: item.class.to_s.downcase,
  #             attributes: {
  #               name: item.name,
  #               description: item.description,
  #               unit_price: item.unit_price,
  #               merchant_id: item.merchant_id
  #             }
  #           }
  #       end
  #     }
  # end

  # def self.new(item)
  #   { data:
  #     { id: "#{item.id}",
  #       type: item.class.to_s.downcase,
  #         attributes: {
  #           name: item.name,
  #           description: item.description,
  #           unit_price: item.unit_price,
  #           merchant_id: item.merchant_id
  #         }
  #     }
  #   }
  # end

