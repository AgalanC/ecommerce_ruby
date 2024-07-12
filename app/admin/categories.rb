ActiveAdmin.register Category do
  permit_params :name, :description

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Category Details' do
      f.input :name
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
