class RemoveAddedAtFromCartItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :cart_items, :added_at, :datetime
  end
end
