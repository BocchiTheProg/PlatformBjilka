class UrgenciesController < ApplicationController
  before_action :set_urgency, only: %i[show edit update destroy]

  # GET /urgencies or /urgencies.json
  def index
    @urgencies = Urgency.all
  end

  # GET /urgencies/1 or /urgencies/1.json
  def show; end

  # GET /urgencies/new
  def new
    @urgency = Urgency.new
  end

  # GET /urgencies/1/edit
  def edit; end

  # POST /urgencies or /urgencies.json
  def create
    @urgency = Urgency.new(urgency_params)

    respond_to do |format|
      if @urgency.save
        format.html { redirect_to urgency_url(@urgency), notice: 'Urgency was successfully created.' }
        format.json { render :show, status: :created, location: @urgency }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @urgency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urgencies/1 or /urgencies/1.json
  def update
    respond_to do |format|
      if @urgency.update(urgency_params)
        format.html { redirect_to urgency_url(@urgency), notice: 'Urgency was successfully updated.' }
        format.json { render :show, status: :ok, location: @urgency }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @urgency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urgencies/1 or /urgencies/1.json
  def destroy
    @urgency.destroy!

    respond_to do |format|
      format.html { redirect_to urgencies_url, notice: 'Urgency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_urgency
    @urgency = Urgency.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def urgency_params
    params.require(:urgency).permit(:title)
  end
end
