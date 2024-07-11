class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :beer
end
