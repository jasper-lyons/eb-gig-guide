require 'rails_helper'

feature 'Admin creates a gig' do
  include AuthHelper

  scenario 'they see the gig in the admin list' do
    http_basic_login
    visit admin_root_path

    click_on 'New gig'
    fill_in 'Name', with: 'A Test Gig'
    click_on 'Create Gig'

    visit admin_root_path
    expect(page).to have_content('A Test Gig')
  end
end
