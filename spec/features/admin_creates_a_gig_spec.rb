require 'rails_helper'

feature 'Admin creates a gig' do
  include AuthHelper

  scenario 'they see the gig in the admin list' do
    http_basic_login
    visit admin_root_path

    click_on 'New gig'
    fill_in 'Name', with: 'A Test Gig'
    fill_in 'Venue', with: 'A Test Venue'
    fill_in 'Date', with: Date.today
    fill_in 'Doors', with: DateTime.now
    fill_in 'Socials', with: '@atestaccount'
    click_on 'Create Gig'

    visit admin_root_path
    expect(page).to have_content('A Test Gig')
  end
end
