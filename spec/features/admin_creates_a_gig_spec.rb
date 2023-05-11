require 'rails_helper'

feature 'Admin creates a gig' do
  scenario 'they see the gig in the admin list' do
    visit admin_path
    click_on 'Create Gig'
    fill_in 'Name', with: 'A Test Gig'
    visit admin_path
    expect(page).to have_content('A Test Gig')
  end
end
