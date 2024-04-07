class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders or /orders.json
  def index
    # @orders = Order.all
    @client_profile_id = params[:client_profile_id]
    @orders = Order.where(client_profile_id: @client_profile_id)
  end

  # GET /orders/1 or /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  # def create
  #   #@order = Order.new(order_params)

  #   #@order.employee_profile_id = params[:employee_id] if params[:employee_id].present?
  #   client_profile = current_client.client_profile || current_client.build_client_profile
  #   @order = client_profile.orders.build(order_params)

  #   respond_to do |format|
  #     if @order.save
  #       format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
  #       format.json { render :show, status: :created, location: @order }
  #     else
  #       puts @order.errors.inspect
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @order.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html do
          flash.now[:alert] = 'Order could not be created.'
          render :new, locals: { order: @order, employee_id: params[:employee_id] }
        end
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status_id, :client_profile_id, :employee_profile_id, :comment_id, :urgency_id, :date_order, :service_id, :price)
  end
end
