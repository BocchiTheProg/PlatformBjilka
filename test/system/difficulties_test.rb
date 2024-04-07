require 'application_system_test_case'

class DifficultiesTest < ApplicationSystemTestCase
  setup do
    @difficulty = difficulties(:one)
  end

  test 'visiting the index' do
    visit difficulties_url
    assert_selector 'h1', text: 'Difficulties'
  end

  test 'should create difficulty' do
    visit difficulties_url
    click_on 'New difficulty'

    fill_in 'Title', with: @difficulty.title
    click_on 'Create Difficulty'

    assert_text 'Difficulty was successfully created'
    click_on 'Back'
  end

  test 'should update Difficulty' do
    visit difficulty_url(@difficulty)
    click_on 'Edit this difficulty', match: :first

    fill_in 'Title', with: @difficulty.title
    click_on 'Update Difficulty'

    assert_text 'Difficulty was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Difficulty' do
    visit difficulty_url(@difficulty)
    click_on 'Destroy this difficulty', match: :first

    assert_text 'Difficulty was successfully destroyed'
  end
end
