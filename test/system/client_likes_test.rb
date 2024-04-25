require 'application_system_test_case'

class ClientLikesTest < ApplicationSystemTestCase
  setup do
    @client_like = client_likes(:one)
  end

  test 'visiting the index' do
    visit client_likes_url
    assert_selector 'h1', text: 'Client likes'
  end

  test 'should create client like' do
    visit client_likes_url
    click_on 'New client like'

    fill_in 'Client profile', with: @client_like.client_profile_id
    fill_in 'Service', with: @client_like.service_id
    click_on 'Create Client like'

    assert_text 'Client like was successfully created'
    click_on 'Back'
  end

  test 'should update Client like' do
    visit client_like_url(@client_like)
    click_on 'Edit this client like', match: :first

    fill_in 'Client profile', with: @client_like.client_profile_id
    fill_in 'Service', with: @client_like.service_id
    click_on 'Update Client like'

    assert_text 'Client like was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Client like' do
    visit client_like_url(@client_like)
    click_on 'Destroy this client like', match: :first

    assert_text 'Client like was successfully destroyed'
  end
end
