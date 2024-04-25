class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    if params[:client_profile_id].present?
      @orders = Order.where(client_profile_id: params[:client_profile_id])
    elsif params[:employee_profile_id].present?
      @orders = Order.where(employee_profile_id: params[:employee_profile_id])
    else
      @orders = Order.all
    end
  end

  # GET /orders/1 or /orders/1.json
  def show

  end

  # GET /orders/new
  def new
      @order = Order.new
  end
  
  # GET /orders/1/edit
  def edit
    # if employee_signed_in?
    #   @order = Order.find_by(employee_profile_id: current_employee.id)
    # else
    #   @order = Order.find_by(client_profile_id: current_client.id)
    # end
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html do
          flash.now[:alert] = "Order could not be created."
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
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
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
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def not_approved_orders
    @orders = Order.where(status_id: Status.find_by(title: "Not Approved").id).order(date_order: :asc)
  end
  
  def approved_orders
    @orders = Order.where(status_id: Status.find_by(title: "Approved").id).order(date_order: :asc)
  end
  
  def in_progress_orders
    @orders = Order.where(status_id: Status.find_by(title: "In Progress").id).order(date_order: :asc)
  end
  
  def done_orders
    @orders = Order.where(status_id: Status.find_by(title: "Done").id).order(date_order: :asc)
  end

  def change_order_status
      @order = Order.find_by(id: params[:order_id])
      case @order.status.title
      when "Not Approved"
        @order.update(status: Status.find_by(title: "Approved"))
        redirect_to approved_orders_path
      when "Approved"
        @order.update(status: Status.find_by(title: "In Progress"))
        redirect_to in_progress_orders_path
      when "In Progress"
        @order.update(status: Status.find_by(title: "Done"))
        redirect_to done_orders_path
      else
        redirect_to done_orders_path
      end      
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      #params.require(:order).permit(:status_id, :client_profile_id, :employee_profile_id, :comment_id, :urgency_id, :date_order, :service_id, :price)
      #params.require(:order).permit(:status_id, :client_profile_id, :employee_profile_id, :urgency_id, :date_order, :service_id, :price, comment_attributes: [:id, :content])
      params.require(:order).permit(:status_id, :client_profile_id, :employee_profile_id, :urgency_id, :date_order, :service_id, :price)
    end
    # def order_params
    #   permitted_params = [:status_id, :client_profile_id, :employee_profile_id, :urgency_id, :date_order, :service_id, :price]
    #   permitted_params << { comment_attributes: [:id, :content] } if params[:order][:comment_attributes].present?
    #   params.require(:order).permit(permitted_params)
    #   debugger
    # end
    
end
