require 'application_system_test_case'

class EmployeeProfilesTest < ApplicationSystemTestCase
  setup do
    @employee_profile = employee_profiles(:one)
  end

  test 'visiting the index' do
    visit employee_profiles_url
    assert_selector 'h1', text: 'Employee profiles'
  end

  test 'should create employee profile' do
    visit employee_profiles_url
    click_on 'New employee profile'

    fill_in 'Date registration', with: @employee_profile.date_registration
    fill_in 'First name', with: @employee_profile.first_name
    fill_in 'Last name', with: @employee_profile.last_name
    fill_in 'Phone', with: @employee_profile.phone
    fill_in 'Specialization', with: @employee_profile.specialization_id
    fill_in 'User', with: @employee_profile.user_id
    click_on 'Create Employee profile'

    assert_text 'Employee profile was successfully created'
    click_on 'Back'
  end

  test 'should update Employee profile' do
    visit employee_profile_url(@employee_profile)
    click_on 'Edit this employee profile', match: :first

    fill_in 'Date registration', with: @employee_profile.date_registration
    fill_in 'First name', with: @employee_profile.first_name
    fill_in 'Last name', with: @employee_profile.last_name
    fill_in 'Phone', with: @employee_profile.phone
    fill_in 'Specialization', with: @employee_profile.specialization_id
    fill_in 'User', with: @employee_profile.user_id
    click_on 'Update Employee profile'

    assert_text 'Employee profile was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Employee profile' do
    visit employee_profile_url(@employee_profile)
    click_on 'Destroy this employee profile', match: :first

    assert_text 'Employee profile was successfully destroyed'
  end
end
