class Review < ApplicationRecord
  belongs_to :user
  belongs_to :beer

  # Validations
  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
  validates :comment, presence: true

  # Allowlist attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[beer_id comment created_at id rating updated_at user_id]
  end
end
