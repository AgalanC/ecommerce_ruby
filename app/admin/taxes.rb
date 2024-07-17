ActiveAdmin.register Tax do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :province, :gst_rate, :pst_rate, :hst_rate, :qst_rate
  #
  # or
  #
  # permit_params do
  #   permitted = [:province, :gst_rate, :pst_rate, :hst_rate, :qst_rate]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :province
    column :gst_rate
    column :pst_rate
    column :hst_rate
    column :qst_rate
    actions
  end

  form do |f|
    f.inputs "Tax Details" do
      f.input :province
      f.input :gst_rate
      f.input :pst_rate
      f.input :hst_rate
      f.input :qst_rate
    end
    f.actions
  end
end
