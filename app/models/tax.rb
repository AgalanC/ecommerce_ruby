class Tax < ApplicationRecord
  has_many :orders

  # Validations
  validates :province, presence: true, uniqueness: true
  validates :gst_rate, :pst_rate, :hst_rate, :qst_rate, numericality: { greater_than_or_equal_to: 0 }

  # Allowlist associations for Ransack (if using search in ActiveAdmin)
  def self.ransackable_associations(auth_object = nil)
    %w[orders]
  end

  # Allowlist attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id province gst_rate pst_rate hst_rate qst_rate created_at updated_at]
  end
end
