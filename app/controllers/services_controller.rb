class ServicesController < ApplicationController
  before_action :set_service, only: %i[ show edit update destroy ]

  require 'yaml'
  # GET /services or /services.json
  def index
    @services = Service.all
  end

  # GET /services/1 or /services/1.json
  def show
  end

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
  def edit
  end

  def search
    if params[:q].present?
      search_term = params[:q]

      if I18n.locale == :uk 
        services_file = "config/locales/uk.yml" 
        result = find_matching_services(search_term, services_file)
        result_keys = result.keys.map(&:parameterize).map(&:underscore)
        @services = Service.all.select do |service|
          result_keys.include?(service.title.parameterize.underscore)
        end
      else
        @services = Service.where("title LIKE ?", "%" + search_term + "%")
      end
    else
      @services = []
    end
  end

  def find_matching_services(search_term, services_file)
    services_data = YAML.load_file(services_file)
    services_titles = services_data["uk"]["index"]["home"]["services_titles"]
  
    matching_services = {}
  
    services_titles.each do |key, value|
      if value.downcase.include?(search_term.downcase)
        matching_services[key] = value
      end
    end
  
    matching_services
  end


  def by_type
    service_type = params[:service_type]
    @services = Service.where(service_type: service_type).pluck(:id, :title)
    render json: @services
  end


  # POST /services or /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to service_url(@service), notice: "Service was successfully created." }
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
        format.html { redirect_to service_url(@service), notice: "Service was successfully updated." }
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
      format.html { redirect_to services_url, notice: "Service was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_params
        params.require(:service).permit(:title, :service_type, :difficulty_id, :employee_profile_id, :description)
    end    
end
