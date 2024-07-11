class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :beer

  # Allowlist attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[beer_id created_at id order_id price quantity updated_at]
  end
end
