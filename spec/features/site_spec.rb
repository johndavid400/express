require 'rails_helper'

feature 'site' do

  before(:each) do
    @site = create(:site)
  end

  scenario 'can view index of sites' do
    site1 = create(:site, name: "Test Site 1")
    site2 = create(:site, name: "Test Site 2")
    visit express.sites_path
    expect(page).to have_content(site1.name)
    expect(page).to have_content(site2.name)
  end

  scenario 'can create a site' do
    visit express.new_site_path
    fill_in("site_name", with: "Test Site")
    click_button('Save')
    expect(page).to have_content('Site was successfully created')
  end

  scenario 'can edit a site' do
    site = create(:site, name: "Test Site")
    visit express.edit_site_path(site)
    fill_in("site_name", with: "Test Site Edited")
    click_button('Save')
    expect(page).to have_content('Site was successfully updated')
  end

end
