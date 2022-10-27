class Merchant < ApplicationRecord
  has_many :items

  scope :filter_name, -> (name) { where(['name ILIKE ?', "%#{name}%"]) }
end