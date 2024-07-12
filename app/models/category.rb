class Category < ApplicationRecord
  has_many :beers

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  # Allowlist associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[beers]
  end

  # Allowlist attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id name description created_at updated_at]
  end
end
