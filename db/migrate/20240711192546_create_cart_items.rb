class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.integer :user_id
      t.integer :beer_id
      t.integer :quantity
      t.decimal :price
      t.datetime :added_at

      t.timestamps
    end
  end
end
