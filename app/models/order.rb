class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tax
  has_many :order_items
  has_many :beers, through: :order_items

  validates :tax_id, :status, presence: true
  validates :status, inclusion: { in: %w[unpaid paid shipped] }

  before_validation :set_default_status, on: :create

  def mark_as_paid
    update(status: 'paid')
  end

  def mark_as_shipped
    update(status: 'shipped')
  end

  def display_name
    "Order ##{id}"
  end

  private

  def set_default_status
    self.status ||= 'unpaid'
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id user_id tax_id status total_price total_tax final_price created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user tax order_items beers]
  end
end
