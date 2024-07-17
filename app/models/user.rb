class User < ApplicationRecord
  has_many :orders
  has_many :reviews
  has_many :cart_items

  validates :username, presence: true, uniqueness: true
end
