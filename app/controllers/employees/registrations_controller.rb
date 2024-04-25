# frozen_string_literal: true

class Employees::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def new
    build_resource({})
    resource.build_employee_profile
    respond_with resource
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, employee_profile_attributes: %i[first_name last_name phone date_registration specialization_id])
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :current_password, employee_profile_attributes: %i[id first_name last_name phone date_registration specialization_id])
    end
  end

  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params.except(:current_password))
    else
      super
    end
  end

  # def update_resource(resource, params)
  #   if params[:password].blank? && params[:password_confirmation].blank?
  #     resource.update(params.except(:password, :password_confirmation, :current_password))
  #   else
  #     super
  #   end
  # end

  # def sign_up_params
  #   params.require(:employee).permit(:email, :password, :password_confirmation,
  #                                    employee_profile_attributes: [:first_name, :last_name, :phone, :date_registration])
  #        .tap { |whitelisted| whitelisted[:employee_profile_attributes][:date_registration] = DateTime.now }
  # end

  def sign_up_params
    params.require(:employee).permit(:email, :password, :password_confirmation,
                                     employee_profile_attributes: %i[first_name last_name phone date_registration specialization_id])
          .tap do |whitelisted|
      current_datetime = DateTime.now
      formatted_datetime = current_datetime.strftime('%d.%m.%Y %H:%M')
      whitelisted[:employee_profile_attributes][:date_registration] = formatted_datetime
    end
  end
end
