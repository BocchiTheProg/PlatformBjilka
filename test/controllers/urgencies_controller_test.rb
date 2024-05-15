require 'test_helper'

class UrgenciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @urgency = urgencies(:one)
  end

  test 'should get index' do
    get urgencies_url
    assert_response :success
  end

  test 'should get new' do
    get new_urgency_url
    assert_response :success
  end

  test 'should create urgency' do
    assert_difference('Urgency.count') do
      post urgencies_url, params: { urgency: { title: @urgency.title } }
    end

    assert_redirected_to urgency_url(Urgency.last)
  end

  test 'should show urgency' do
    get urgency_url(@urgency)
    assert_response :success
  end

  test 'should get edit' do
    get edit_urgency_url(@urgency)
    assert_response :success
  end

  test 'should update urgency' do
    patch urgency_url(@urgency), params: { urgency: { title: @urgency.title } }
    assert_redirected_to urgency_url(@urgency)
  end

  test 'should destroy urgency' do
    assert_difference('Urgency.count', -1) do
      delete urgency_url(@urgency)
    end

    assert_redirected_to urgencies_url
  end
end
