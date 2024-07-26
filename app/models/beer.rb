class Beer < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews
  has_many :cart_items

  # Add this line to enable image attachment
  has_one_attached :image

  # Validations
  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }

  # Allowlist associations for Ransack (if using search in ActiveAdmin)
  def self.ransackable_associations(auth_object = nil)
    %w[category order_items orders reviews cart_items]
  end

  # Allowlist attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[beer_type category_id created_at description id name price stock_quantity updated_at]
  end

  # Scopes for filtering beers
  scope :new_beers, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago) }
end
