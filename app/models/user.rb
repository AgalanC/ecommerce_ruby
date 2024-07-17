class User < ApplicationRecord
  has_many :orders
  has_many :reviews
  has_many :cart_items

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :address, presence: true
end
