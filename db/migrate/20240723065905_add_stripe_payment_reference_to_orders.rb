class AddStripePaymentReferenceToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :stripe_payment_reference, :string
  end
end
