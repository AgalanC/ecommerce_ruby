=begin
ActiveAdmin.register StaticPage do
  permit_params :title, :content

  index do
    selectable_column
    id_column
    column :title
    column :content do |page|
      truncate(page.content, length: 100)
    end
    actions
  end

  form do |f|
    f.inputs 'Static Page Details' do
      f.input :title
      f.input :content, as: :quill_editor
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :content do |page|
        raw page.content
      end
    end
    active_admin_comments
  end

  filter :title
end
=end

ActiveAdmin.register StaticPage do
  permit_params :title, :content

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Static Page Details' do
      f.input :title
      f.input :content, as: :text
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :content
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
