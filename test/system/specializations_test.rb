require 'application_system_test_case'

class SpecializationsTest < ApplicationSystemTestCase
  setup do
    @specialization = specializations(:one)
  end

  test 'visiting the index' do
    visit specializations_url
    assert_selector 'h1', text: 'Specializations'
  end

  test 'should create specialization' do
    visit specializations_url
    click_on 'New specialization'

    fill_in 'Title', with: @specialization.title
    click_on 'Create Specialization'

    assert_text 'Specialization was successfully created'
    click_on 'Back'
  end

  test 'should update Specialization' do
    visit specialization_url(@specialization)
    click_on 'Edit this specialization', match: :first

    fill_in 'Title', with: @specialization.title
    click_on 'Update Specialization'

    assert_text 'Specialization was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Specialization' do
    visit specialization_url(@specialization)
    click_on 'Destroy this specialization', match: :first

    assert_text 'Specialization was successfully destroyed'
  end
end
