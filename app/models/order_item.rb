class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :beer

  validates :order_id, :beer_id, :quantity, presence: true # Ensure foreign keys and quantity are present

  # Allowlist attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[beer_id created_at id order_id price quantity updated_at]
  end

  # Allowlist associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[order beer]
  end
end
