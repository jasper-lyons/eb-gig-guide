require 'rails_helper'

feature 'Admin creates a Venue' do
  include AuthHelper

  scenario 'they see the venue on the admin list' do
    http_basic_login
    visit admin_root_path

    click_on 'Venues'
    click_on 'New venue'
    fill_in 'Name', with: 'A Test Venue'
    click_on 'Create Venue'

    visit admin_root_path
    click_on 'Venues'
    expect(page).to have_content('A Test Venue')
  end

  scenario 'they see the venue in the gig venue dropdown' do
    http_basic_login
    visit admin_root_path

    click_on 'Venues'
    click_on 'New venue'
    fill_in 'Name', with: 'A Test Venue'
    click_on 'Create Venue'

    visit admin_root_path
    click_on 'Gigs'
    click_on 'New gig'
    expect(page).to have_select('Venue', with_options: ['A Test Venue'])
  end
end
