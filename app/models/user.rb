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

  # Define ransackable associations for Ransack search
  def self.ransackable_associations(auth_object = nil)
    %w[orders cart_items reviews]
  end

  # Define ransackable attributes for Ransack search
  def self.ransackable_attributes(auth_object = nil)
    %w[id name email address role created_at updated_at username]
  end
end
