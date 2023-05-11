require 'rails_helper'

feature 'Guest visits the index page' do
  scenario 'they see the set of gigs currently on' do
    gigs = [
      create(:gig),
      create(:gig),
      create(:gig)
    ]

    visit root_path

    gigs.each do |gig|
      expect(page).to have_content(gig.name)
      expect(page).to have_content(gig.venue)
    end
  end

  scenario 'they visit a specific gig' do
    gig = create(:gig)

    visit root_path

    click_link(gig.name)

    expect(page).to have_content(gig.name)
  end
end
