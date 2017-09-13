require 'rails_helper'

feature 'entry' do

  before(:each) do
    create(:channel, slug: "test")
  end

  scenario 'can create an entry' do
    visit express.channels_path
    expect(page).to have_no_content('Listing Channels')
  end

end
