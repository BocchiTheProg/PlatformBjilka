class ClientProfilesController < ApplicationController
  before_action :set_client_profile, only: %i[show edit update destroy]

  # GET /client_profiles/new
  def new
    @client_profile = ClientProfile.new
    @client_profile.build_client unless @client_profile.client
    # @client_profile.build_user
  end

  # GET /client_profiles/1/edit
  def edit
    # @client_profile.build_client unless @client_profile.client
  end

  def calendar
    current_client_id = params[:current_client_id]
    @orders = Order.where(client_profile_id: current_client_id)
    render 'orders/calendar'
  end

  # POST /client_profiles or /client_profiles.json
  def create
    @client_profile = ClientProfile.new(client_profile_params)

    respond_to do |format|
      if @client_profile.save
        format.html { redirect_to @client_profile, notice: 'Client profile was successfully created.' }
        format.json { render :show, status: :created, location: @client_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_profiles/1 or /client_profiles/1.json
  def update
    respond_to do |format|
      if @client_profile.update(client_profile_params)
        format.html { redirect_to @client_profile, notice: 'Client profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_profiles/1 or /client_profiles/1.json
  def destroy
    @client_profile.destroy!

    respond_to do |format|
      format.html { redirect_to client_profiles_url, notice: 'Client profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client_profile
    @client_profile = ClientProfile.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def client_profile_params
    # params.require(:client_profile).permit(:first_name, :last_name, :phone,  client_attributes: [:id, :email, :password])
    # params.require(:client_profile).permit(:first_name, :last_name, :phone,  client_attributes: [:id, :email])
    permitted_params = if params[:client_profile][:client_attributes][:password].present?
                         [:first_name, :last_name, :phone, { client_attributes: %i[id email password] }]
                       else
                         [:first_name, :last_name, :phone, { client_attributes: %i[id email] }]
                       end
    params.require(:client_profile).permit(permitted_params)
  end
end
