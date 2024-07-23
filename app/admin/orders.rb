ActiveAdmin.register Order do
  permit_params :user_id, :tax_id, :status, :total_price, :total_tax, :final_price

  index do
    selectable_column
    id_column
    column :user
    column :tax do |order|
      order.tax.province
    end
    column :status
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
      row :tax do |order|
        order.tax.province
      end
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
      f.input :tax, as: :select, collection: Tax.all.map { |tax| [tax.province, tax.id] }, include_blank: false
      f.input :status, as: :select, collection: %w[new paid shipped]
      f.input :total_price
      f.input :total_tax
      f.input :final_price
    end
    f.actions
  end

  filter :user
  filter :tax, as: :select, collection: Tax.all.map { |tax| [tax.province, tax.id] }
  filter :status, as: :select, collection: %w[new paid shipped]
  filter :total_price
  filter :total_tax
  filter :final_price
  filter :created_at
end
