class CreateBeers < ActiveRecord::Migration[7.1]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :stock_quantity
      t.integer :category_id
      t.string :beer_type

      t.timestamps
    end
  end
end
