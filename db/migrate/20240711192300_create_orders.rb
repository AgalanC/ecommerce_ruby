class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :tax_id
      t.string :status
      t.decimal :total_price
      t.decimal :total_tax
      t.decimal :final_price

      t.timestamps
    end
  end
end
