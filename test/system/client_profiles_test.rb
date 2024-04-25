require 'application_system_test_case'

class ClientProfilesTest < ApplicationSystemTestCase
  setup do
    @client_profile = client_profiles(:one)
  end

  test 'visiting the index' do
    visit client_profiles_url
    assert_selector 'h1', text: 'Client profiles'
  end

  test 'should create client profile' do
    visit client_profiles_url
    click_on 'New client profile'

    fill_in 'First name', with: @client_profile.first_name
    fill_in 'Last name', with: @client_profile.last_name
    fill_in 'Phone', with: @client_profile.phone
    fill_in 'User', with: @client_profile.user_id
    click_on 'Create Client profile'

    assert_text 'Client profile was successfully created'
    click_on 'Back'
  end

  test 'should update Client profile' do
    visit client_profile_url(@client_profile)
    click_on 'Edit this client profile', match: :first

    fill_in 'First name', with: @client_profile.first_name
    fill_in 'Last name', with: @client_profile.last_name
    fill_in 'Phone', with: @client_profile.phone
    fill_in 'User', with: @client_profile.user_id
    click_on 'Update Client profile'

    assert_text 'Client profile was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Client profile' do
    visit client_profile_url(@client_profile)
    click_on 'Destroy this client profile', match: :first

    assert_text 'Client profile was successfully destroyed'
  end
end
