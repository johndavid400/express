require 'rails_helper'

feature 'setting' do

  before(:each) do
  end

  scenario 'can view index of settings' do
    setting1 = create(:setting, name: "Test Setting 1")
    setting2 = create(:setting, name: "Test Setting 2")
    visit express.settings_path
    expect(page).to have_content(setting1.name)
    expect(page).to have_content(setting2.name)
  end

  scenario 'can create a setting' do
    visit express.new_setting_path
    fill_in("setting_name", with: "Test Setting")
    click_button('Save')
    expect(page).to have_content('Setting was successfully created')
  end

  scenario 'can edit a setting' do
    setting = create(:setting, name: "Test Setting")
    visit express.edit_setting_path(setting)
    fill_in("setting_name", with: "Test Setting Edited")
    click_button('Save')
    expect(page).to have_content('Setting was successfully updated')
  end

end
