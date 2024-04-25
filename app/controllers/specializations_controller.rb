class SpecializationsController < ApplicationController
  before_action :set_specialization, only: %i[show edit update destroy]

  # GET /specializations or /specializations.json
  def index
    @specializations = Specialization.all
  end

  # GET /specializations/1 or /specializations/1.json
  def show; end

  # GET /specializations/new
  def new
    @specialization = Specialization.new
  end

  # GET /specializations/1/edit
  def edit; end

  # POST /specializations or /specializations.json
  def create
    @specialization = Specialization.new(specialization_params)

    respond_to do |format|
      if @specialization.save
        format.html { redirect_to specialization_url(@specialization), notice: 'Specialization was successfully created.' }
        format.json { render :show, status: :created, location: @specialization }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @specialization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /specializations/1 or /specializations/1.json
  def update
    respond_to do |format|
      if @specialization.update(specialization_params)
        format.html { redirect_to specialization_url(@specialization), notice: 'Specialization was successfully updated.' }
        format.json { render :show, status: :ok, location: @specialization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @specialization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specializations/1 or /specializations/1.json
  def destroy
    @specialization.destroy!

    respond_to do |format|
      format.html { redirect_to specializations_url, notice: 'Specialization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_specialization
    @specialization = Specialization.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def specialization_params
    params.require(:specialization).permit(:title)
  end
end
