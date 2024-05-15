ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :status_id, :client_profile_id, :employee_profile_id, :urgency_id, :date_order, :service_id, :price
  #
  # or
  #
  # permit_params do
  #   permitted = [:status_id, :client_profile_id, :employee_profile_id, :urgency_id, :date_order, :service_id, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
