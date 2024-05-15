# frozen_string_literal: true

class Clients::SessionsController < Devise::SessionsController
  def create
    client = Client.find_by(email: params[:client][:email])

    if client && client.valid_password?(params[:client][:password])
      sign_in(client)
      redirect_to root_path
    else
      employee = Employee.find_by(email: params[:client][:email])

      if employee && employee.valid_password?(params[:client][:password])
        sign_in(employee)
        redirect_to root_path
      else
        flash[:alert] = 'Invalid email or password'
        redirect_to new_client_session_path
      end
    end
  end

  # before_action :configure_sign_in_params, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
