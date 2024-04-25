require 'test_helper'

class ClientLikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_like = client_likes(:one)
  end

  test 'should get index' do
    get client_likes_url
    assert_response :success
  end

  test 'should get new' do
    get new_client_like_url
    assert_response :success
  end

  test 'should create client_like' do
    assert_difference('ClientLike.count') do
      post client_likes_url, params: { client_like: { client_profile_id: @client_like.client_profile_id, service_id: @client_like.service_id } }
    end

    assert_redirected_to client_like_url(ClientLike.last)
  end

  test 'should show client_like' do
    get client_like_url(@client_like)
    assert_response :success
  end

  test 'should get edit' do
    get edit_client_like_url(@client_like)
    assert_response :success
  end

  test 'should update client_like' do
    patch client_like_url(@client_like), params: { client_like: { client_profile_id: @client_like.client_profile_id, service_id: @client_like.service_id } }
    assert_redirected_to client_like_url(@client_like)
  end

  test 'should destroy client_like' do
    assert_difference('ClientLike.count', -1) do
      delete client_like_url(@client_like)
    end

    assert_redirected_to client_likes_url
  end
end
