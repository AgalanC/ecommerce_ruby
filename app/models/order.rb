class Order < ApplicationRecord
  belongs_to :user
  belongs_to :tax
  has_many :order_items
  has_many :beers, through: :order_items

  validates :user_id, :tax_id, presence: true # Ensure foreign keys are present

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "final_price", "id", "status", "tax_id", "total_price", "total_tax", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["beers", "order_items", "tax", "user"]
  end
end
