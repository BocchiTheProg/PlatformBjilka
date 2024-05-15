class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  require 'csv'

  # GET /orders or /orders.json
  def index
    if params[:client_profile_id].present?
      @orders = Order.where(client_profile_id: params[:client_profile_id])
    elsif params[:employee_profile_id].present?
      @orders = Order.where(employee_profile_id: params[:employee_profile_id])
    else
      @orders = Order.all
    end

    if client_signed_in?
      @orders = Order.where(client_profile_id: current_client.id)
      respond_to do |format|
        format.html
        format.csv do
          filename = ['Orders', Date.today].join(' ')
          response.headers['Content-Type'] = 'text/csv'
          response.headers['Content-Disposition'] = "attachment; filename=#{filename}.csv"
          render template: 'orders/index'
        end
      end
    end     
  end


  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
    related_orders = Order.where(service_id: @order.service_id, employee_profile_id: @order.employee_profile_id)
    @comments = Comment.where(order_id: related_orders.pluck(:id)).order(created_at: :desc)
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
        @order.reload
        orders = Order.where(employee_profile_id: @order.employee_profile_id, status_id: Status.find_by(title: "Done").id)
        average_rating = orders.average(:rating)
        average_rating ||= 0
        EmployeeProfile.find(@order.employee_profile_id).update(rating: average_rating)
        
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

  def orders_sorted_by_date
    @orders = Order.where(client_profile_id: params[:client_profile_id]).order(date_order: :asc)
  end


  def orders_sorted_by_comments_quantity
    @orders = Order.where(client_profile_id: params[:client_profile_id])
    client_orders = Order.where(client_profile_id: params[:client_profile_id])
    
    comments_count_by_order_id = {}

    client_orders.each do |order|
      comments_count = Comment.where(order_id: order.id).count
      if comments_count == 0 
        comments_count_by_order_id[order.id] = 0
      else
        comments_count_by_order_id[order.id] = comments_count
      end
    end
    
    other_orders = Order.where.not(client_profile_id: params[:client_profile_id])
    
    other_orders.each do |order|
      matching_order = client_orders.find_by(employee_profile_id: order.employee_profile_id, service_id: order.service_id)
      if matching_order && order.client_profile_id != params[:client_profile_id]
        comments_count_by_order_id[matching_order.id] ||= 0
        comments_count_by_order_id[matching_order.id] += Comment.where(order_id: order.id).count
      end
    end
    
    @result_hash = comments_count_by_order_id.transform_keys(&:to_s)
    @orders = @orders.sort_by { |order| -comments_count_by_order_id[order.id] }
  end

  def orders_sorted_by_rating
    @orders = Order.where(client_profile_id: params[:client_profile_id]).where(status_id: Status.find_by(title: "Done").id).order(rating: :desc)
  end

  def orders_sorted_by_services
    @orders = Order.where(client_profile_id: params[:client_profile_id]).joins(:service).order('services.title ASC')
  end
  

  def not_approved_orders
    @orders = Order.where(status_id: Status.find_by(title: "Not Approved").id).where(employee_profile_id: params[:employee_profile_id]).order(date_order: :asc)
  end
  

  def approved_orders
    @orders = Order.where(status_id: Status.find_by(title: "Approved").id).where(employee_profile_id: params[:employee_profile_id]).order(date_order: :asc)
  end
  

  def in_progress_orders
    @orders = Order.where(status_id: Status.find_by(title: "In Progress").id).where(employee_profile_id: params[:employee_profile_id]).order(date_order: :asc)
  end
  
  
  def done_orders
    @orders = Order.where(status_id: Status.find_by(title: "Done").id).where(employee_profile_id: params[:employee_profile_id]).order(date_order: :asc)
  end

  def change_order_status
      @order = Order.find_by(id: params[:order_id])
      case @order.status.title
      when "Not Approved"
        @order.update(status: Status.find_by(title: "Approved"))
        redirect_to approved_orders_path(employee_profile_id: params[:employee_profile_id])
      when "Approved"
        @order.update(status: Status.find_by(title: "In Progress"))
        redirect_to in_progress_orders_path(employee_profile_id: params[:employee_profile_id])
      when "In Progress"
        @order.update(status: Status.find_by(title: "Done"))
        redirect_to done_orders_path(employee_profile_id: params[:employee_profile_id])
      else
        redirect_to done_orders_path(employee_profile_id: params[:employee_profile_id])
      end      
  end


  def best_employees
    all_orders = Order.where(status_id: Status.find_by(title: "Done").id)
    ratings_hash = Hash.new { |hash, key| hash[key] = [] }

    all_orders.each do |order|
      ratings_hash[order.employee_profile_id] << order.rating
    end

    average_ratings_hash = {}
    ratings_hash.each do |employee_id, ratings|
      average_rating = ratings.sum.to_f / ratings.size
      average_ratings_hash[employee_id] = average_rating
    end

    sorted_average_ratings_hash = average_ratings_hash.sort_by { |_, rating| -rating }.to_h
    @top_employees = sorted_average_ratings_hash.take(3)
  end

  
  def best_employees_index
    @orders = Order.where(status_id: Status.find_by(title: "Done").id).where(employee_profile_id: params[:employee_profile_id]).order(rating: :desc)
    render 'index'
  end

  
  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      #params.require(:order).permit(:status_id, :client_profile_id, :employee_profile_id, :comment_id, :urgency_id, :date_order, :service_id, :price)
      #params.require(:order).permit(:status_id, :client_profile_id, :employee_profile_id, :urgency_id, :date_order, :service_id, :price, comment_attributes: [:id, :content])
      params.require(:order).permit(:status_id, :client_profile_id, :employee_profile_id, :urgency_id, :date_order, :service_id, :price, :avatar, :rating)
    end
    # def order_params
    #   permitted_params = [:status_id, :client_profile_id, :employee_profile_id, :urgency_id, :date_order, :service_id, :price]
    #   permitted_params << { comment_attributes: [:id, :content] } if params[:order][:comment_attributes].present?
    #   params.require(:order).permit(permitted_params)
    #   debugger
    # end
end
