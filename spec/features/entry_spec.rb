require 'rails_helper'

feature 'entry' do

  before(:each) do
    @channel = create(:channel, slug: "test")
  end

  scenario 'can view index of entries' do
    entry1 = create(:entry, title: "Test Entry 1", channel_id: @channel.id)
    entry2 = create(:entry, title: "Test Entry 2", channel_id: @channel.id)
    visit express.channel_entries_path(@channel)
    expect(page).to have_content(entry1.title)
    expect(page).to have_content(entry2.title)
  end

  scenario 'can create an entry' do
    visit express.new_channel_entry_path(@channel)
    fill_in("entry_title", with: "Tester")
    click_button('Save')
    expect(page).to have_content('Entry was successfully created')
  end

  scenario 'can edit an entry' do
    entry = create(:entry, channel_id: @channel.id)
    visit express.edit_channel_entry_path(@channel, entry)
    fill_in("entry_title", with: "Tester Edited")
    click_button('Save')
    expect(page).to have_content('Entry was successfully updated')
  end

end
