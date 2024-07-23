ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :password, :role, :address, :username

  filter :id
  filter :name
  filter :email
  filter :address
  filter :username
  filter :role
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address
    column :username
    column :role
    column :created_at
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :role
      f.input :address
      f.input :username
    end
    f.actions
  end
end
