require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test 'should get index' do
    get orders_url
    assert_response :success
  end

  test 'should get new' do
    get new_order_url
    assert_response :success
  end

  test 'should create order' do
    assert_difference('Order.count') do
      post orders_url, params: { order: { client_profile_id: @order.client_profile_id, comment_id: @order.comment_id, date_order: @order.date_order, employee_id: @order.employee_id, price: @order.price, service_id: @order.service_id, status_id: @order.status_id, urgency_id: @order.urgency_id } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test 'should show order' do
    get order_url(@order)
    assert_response :success
  end

  test 'should get edit' do
    get edit_order_url(@order)
    assert_response :success
  end

  test 'should update order' do
    patch order_url(@order), params: { order: { client_profile_id: @order.client_profile_id, comment_id: @order.comment_id, date_order: @order.date_order, employee_id: @order.employee_id, price: @order.price, service_id: @order.service_id, status_id: @order.status_id, urgency_id: @order.urgency_id } }
    assert_redirected_to order_url(@order)
  end

  test 'should destroy order' do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
