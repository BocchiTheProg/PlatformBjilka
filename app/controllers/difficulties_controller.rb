class DifficultiesController < ApplicationController
  before_action :set_difficulty, only: %i[show edit update destroy]

  # GET /difficulties or /difficulties.json
  def index
    @difficulties = Difficulty.all
  end

  # GET /difficulties/1 or /difficulties/1.json
  def show; end

  # GET /difficulties/new
  def new
    @difficulty = Difficulty.new
  end

  # GET /difficulties/1/edit
  def edit; end

  # POST /difficulties or /difficulties.json
  def create
    @difficulty = Difficulty.new(difficulty_params)

    respond_to do |format|
      if @difficulty.save
        format.html { redirect_to difficulty_url(@difficulty), notice: 'Difficulty was successfully created.' }
        format.json { render :show, status: :created, location: @difficulty }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @difficulty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /difficulties/1 or /difficulties/1.json
  def update
    respond_to do |format|
      if @difficulty.update(difficulty_params)
        format.html { redirect_to difficulty_url(@difficulty), notice: 'Difficulty was successfully updated.' }
        format.json { render :show, status: :ok, location: @difficulty }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @difficulty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /difficulties/1 or /difficulties/1.json
  def destroy
    @difficulty.destroy!

    respond_to do |format|
      format.html { redirect_to difficulties_url, notice: 'Difficulty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_difficulty
    @difficulty = Difficulty.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def difficulty_params
    params.require(:difficulty).permit(:title)
  end
end
