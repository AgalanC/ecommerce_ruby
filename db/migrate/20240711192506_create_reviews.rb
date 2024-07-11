class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :beer_id
      t.integer :rating
      t.string :comment

      t.timestamps
    end
  end
end
