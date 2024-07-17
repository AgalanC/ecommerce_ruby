ActiveAdmin.register OrderItem do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :order_id, :beer_id, :quantity, :price
  #
  # or
  #
  # permit_params do
  #   permitted = [:order_id, :beer_id, :quantity, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :order
    column :beer
    column :quantity
    column :price
    column "Total" do |item|
      number_to_currency(item.price * item.quantity)
    end
    actions
  end

  form do |f|
    f.inputs "Order Item Details" do
      f.input :order
      f.input :beer
      f.input :quantity
      f.input :price
    end
    f.actions
  end
end
