class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update destroy]

  # GET /services or /services.json
  def index
    @services = Service.all
  end

  # GET /services/1 or /services/1.json
  def show; end

  # GET /services/new
  def new
    @service = Service.new
    if params[:current_employee_id].present?
      @current_employee = Employee.find(params[:current_employee_id])
      puts "Current employee ID: #{@current_employee.id}"
      @service.employee_profile_id = @current_employee.id
    end
    puts "Service attributes: #{@service.attributes}"
  end

  # GET /services/1/edit
  def edit; end

  def search
    @services = if params[:q].present?
                  Service.where('title LIKE ?', '%' + params[:q] + '%')
                else
                  []
                end
  end

  def by_type
    service_type = params[:service_type]
    @services = Service.where(service_type:).pluck(:id, :title)
    render json: @services
  end

  # POST /services or /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to service_url(@service), notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1 or /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to service_url(@service), notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1 or /services/1.json
  def destroy
    @service.destroy!

    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_to_favorites
    @service = Service.find(params[:id])
    current_client.client_profile.client_likes.create(service: @service)
    redirect_to @service, notice: 'Service added to favourites'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def service_params
    params.require(:service).permit(:title, :service_type, :difficulty_id, :employee_profile_id)
  end
end
