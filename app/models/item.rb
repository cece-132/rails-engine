class Item < ApplicationRecord
  validates :name, uniqueness: {case_sensitive: false}

  enum status: ["Enabled", "Disabled"]
  belongs_to :merchant
  has_many :invoice_items, :dependent => :destroy
  has_many :invoices, through: :invoice_items
  has_many :items, through: :invoice_items

  after_destroy :cleanup
  
  scope :filter_name, -> (name) { where(['name ILIKE ? OR description = ?', "%#{name}%", "%#{name}%"]) }
  scope :filter_max_price, -> (max_price) { where('unit_price <= ?', max_price).order(:name) }
  scope :filter_min_price, -> (min_price) { where('unit_price >= ?', min_price).order(:name) }

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  def self.find_one_item(item_name_params)
   where("lower(name) like lower('%#{item_name_params}%')").order(:name).first
  end

  def self.price_between(max, min)
    where('unit_price <= ? and unit_price >= ?', max, min).order(unit_price: :desc)
  end

  def self.greater_than_min_price(min)
    where('unit_price >= ?', min)
  end

  def self.less_than_max_price(max)
    where('unit_price <= ?', max).order(:unit_price)
  end

  private

  def cleanup
    Invoice.left_joins(:invoice_items)
    .select('invoices.*, count(invoice_items) as total_inv')
    .having('count(invoice_items) = ?', 0)
    .group(:id)
    .destroy_all
  end

end