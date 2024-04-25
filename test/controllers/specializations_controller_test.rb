require 'test_helper'

class SpecializationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @specialization = specializations(:one)
  end

  test 'should get index' do
    get specializations_url
    assert_response :success
  end

  test 'should get new' do
    get new_specialization_url
    assert_response :success
  end

  test 'should create specialization' do
    assert_difference('Specialization.count') do
      post specializations_url, params: { specialization: { title: @specialization.title } }
    end

    assert_redirected_to specialization_url(Specialization.last)
  end

  test 'should show specialization' do
    get specialization_url(@specialization)
    assert_response :success
  end

  test 'should get edit' do
    get edit_specialization_url(@specialization)
    assert_response :success
  end

  test 'should update specialization' do
    patch specialization_url(@specialization), params: { specialization: { title: @specialization.title } }
    assert_redirected_to specialization_url(@specialization)
  end

  test 'should destroy specialization' do
    assert_difference('Specialization.count', -1) do
      delete specialization_url(@specialization)
    end

    assert_redirected_to specializations_url
  end
end
