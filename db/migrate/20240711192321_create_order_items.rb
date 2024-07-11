class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :beer_id
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
