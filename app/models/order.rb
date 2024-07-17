class Order < ApplicationRecord
  belongs_to :user
  belongs_to :tax
  has_many :order_items
  has_many :beers, through: :order_items

  validates :user_id, :tax_id, presence: true # Ensure foreign keys are present
end
