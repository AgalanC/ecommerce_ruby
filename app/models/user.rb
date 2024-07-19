class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :reviews
  has_many :cart_items

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :address, presence: true

  # Added methods for province
  def province
    orders.last&.tax&.province
  end

  def province=(province_name)
    tax = Tax.find_by(province: province_name)
    if tax
      orders.each do |order|
        order.update(tax: tax)
      end
    end
  end
end
