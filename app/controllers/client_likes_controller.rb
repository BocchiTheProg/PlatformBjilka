class ClientLikesController < ApplicationController
  before_action :set_client_like, only: %i[show edit update destroy]

  # GET /client_likes or /client_likes.json
  def index
    # @client_likes = ClientLike.all
    @client_likes = ClientLike.joins(:service).order('services.title')
  end

  # GET /client_likes/1 or /client_likes/1.json
  def show
  end

  # GET /client_likes/new
  def new
    @client_like = ClientLike.new
  end

  # GET /client_likes/1/edit
  def edit
  end

  # POST /client_likes or /client_likes.json
  def create
    @client_like = ClientLike.new(client_like_params)

    respond_to do |format|
      if @client_like.save
        format.html { redirect_to client_like_url(@client_like), notice: "Client like was successfully created." }
        format.json { render :show, status: :created, location: @client_like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client_like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_likes/1 or /client_likes/1.json
  def update
    respond_to do |format|
      if @client_like.update(client_like_params)
        format.html { redirect_to client_like_url(@client_like), notice: "Client like was successfully updated." }
        format.json { render :show, status: :ok, location: @client_like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client_like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_likes/1 or /client_likes/1.json
  def destroy
    @client_like.destroy!

    respond_to do |format|
      format.html { redirect_to client_likes_url, notice: "Client like was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client_like
    @client_like = ClientLike.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def client_like_params
    params.require(:client_like).permit(:client_profile_id, :service_id)
  end
end
