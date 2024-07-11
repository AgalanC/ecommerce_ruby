class Beer < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews
  has_many :cart_items

  # Allowlist associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[category order_items orders reviews cart_items]
  end

  # Allowlist attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[beer_type category_id created_at description id name price stock_quantity updated_at]
  end
end
