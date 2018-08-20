require 'rails_helper'

feature 'channel' do

  before(:each) do
    @site = create(:site)
  end

  scenario 'can view index of channels' do
    channel1 = create(:channel, title: "Test Channel 1", site_id: @site.id)
    channel2 = create(:channel, title: "Test Channel 2", site_id: @site.id)
    visit express.channels_path
    expect(page).to have_content(channel1.title)
    expect(page).to have_content(channel2.title)
  end

  scenario 'can create a channel' do
    visit express.new_channel_path
    fill_in("channel_title", with: "Test Channel")
    click_button('Save')
    expect(page).to have_content('Channel was successfully created')
  end

  scenario 'can edit a channel' do
    channel = create(:channel, title: "Test Channel", site_id: @site.id)
    visit express.edit_channel_path(channel)
    fill_in("channel_title", with: "Test Channel Edited")
    click_button('Save')
    expect(page).to have_content('Channel was successfully updated')
  end

end
