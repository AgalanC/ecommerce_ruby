ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :tax_id, :status, :total_price, :total_tax, :final_price
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :tax_id, :status, :total_price, :total_tax, :final_price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :user
    column :tax
    column :total_price
    column :total_tax
    column :final_price
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :tax
      row :status
      row :total_price
      row :total_tax
      row :final_price
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :beer
        column :quantity
        column :price
        column "Total" do |item|
          number_to_currency(item.price * item.quantity)
        end
      end
    end
  end

  form do |f|
    f.inputs "Order Details" do
      f.input :user
      f.input :tax
      f.input :status
      f.input :total_price
      f.input :total_tax
      f.input :final_price
    end
    f.actions
  end
end
