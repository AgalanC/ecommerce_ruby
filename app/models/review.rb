class Review < ApplicationRecord
  belongs_to :user
  belongs_to :beer

  # Allowlist attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[beer_id comment created_at id rating updated_at user_id]
  end
end
