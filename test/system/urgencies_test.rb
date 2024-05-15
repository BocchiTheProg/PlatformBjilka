require 'application_system_test_case'

class UrgenciesTest < ApplicationSystemTestCase
  setup do
    @urgency = urgencies(:one)
  end

  test 'visiting the index' do
    visit urgencies_url
    assert_selector 'h1', text: 'Urgencies'
  end

  test 'should create urgency' do
    visit urgencies_url
    click_on 'New urgency'

    fill_in 'Title', with: @urgency.title
    click_on 'Create Urgency'

    assert_text 'Urgency was successfully created'
    click_on 'Back'
  end

  test 'should update Urgency' do
    visit urgency_url(@urgency)
    click_on 'Edit this urgency', match: :first

    fill_in 'Title', with: @urgency.title
    click_on 'Update Urgency'

    assert_text 'Urgency was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Urgency' do
    visit urgency_url(@urgency)
    click_on 'Destroy this urgency', match: :first

    assert_text 'Urgency was successfully destroyed'
  end
end
