class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :beer

  # Validations
  validates :user_id, :beer_id, :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  # Allowlist attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[added_at beer_id created_at id price quantity updated_at user_id]
  end
end
