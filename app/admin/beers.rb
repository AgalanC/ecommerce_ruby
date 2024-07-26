ActiveAdmin.register Beer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :stock_quantity, :category_id, :beer_type, :image, order_items_attributes: [:id, :order_id, :beer_id, :quantity, :price, :_destroy]
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :stock_quantity, :category_id, :beer_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs 'Beer Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
      f.input :beer_type
      f.input :image, as: :file
    end

    f.inputs "Order Items" do
      f.has_many :order_items, allow_destroy: true, new_record: true do |oi|
        oi.input :order
        oi.input :quantity
        oi.input :price
      end
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :category
    column :beer_type
    column :image do |beer|
      if beer.image.attached?
        image_tag url_for(beer.image), size: "50x50"
      end
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :category
      row :beer_type
      row :image do |beer|
        if beer.image.attached?
          image_tag url_for(beer.image), size: "300x300"
        end
      end
    end
    active_admin_comments
  end

  filter :name
  filter :description
  filter :price
  filter :stock_quantity
  filter :category
  filter :beer_type
  # Do not include image_attachment_id_eq or any other non-existent attributes here
end
