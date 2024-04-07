class EmployeeProfilesController < ApplicationController
  before_action :set_employee_profile, only: %i[show edit update destroy]

  # GET /employee_profiles or /employee_profiles.json
  def index
    @employee_profiles = EmployeeProfile.all
  end

  # GET /employee_profiles/1 or /employee_profiles/1.json
  def show; end

  # GET /employee_profiles/new
  def new
    @employee_profile = EmployeeProfile.new
  end

  # GET /employee_profiles/1/edit
  def edit; end

  def calendar
    current_employee_id = params[:current_employee_id]
    @orders = Order.where(employee_profile_id: current_employee_id)
    render 'orders/calendar'
  end

  # POST /employee_profiles or /employee_profiles.json
  def create
    @employee_profile = EmployeeProfile.new(employee_profile_params)

    respond_to do |format|
      if @employee_profile.save
        format.html { redirect_to employee_profile_url(@employee_profile), notice: 'Employee profile was successfully created.' }
        format.json { render :show, status: :created, location: @employee_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_profiles/1 or /employee_profiles/1.json
  def update
    respond_to do |format|
      if @employee_profile.update(employee_profile_params)
        format.html { redirect_to employee_profile_url(@employee_profile), notice: 'Employee profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_profiles/1 or /employee_profiles/1.json
  def destroy
    @employee_profile.destroy!

    respond_to do |format|
      format.html { redirect_to employee_profiles_url, notice: 'Employee profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee_profile
    @employee_profile = EmployeeProfile.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_profile_params
    params.require(:employee_profile).permit(:first_name, :last_name, :phone, :date_registration, :user_id, :specialization_id)
  end
end
