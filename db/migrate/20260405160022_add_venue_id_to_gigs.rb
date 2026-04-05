class AddVenueIdToGigs < ActiveRecord::Migration[7.0]
  def change
    add_reference :gigs, :venue, null: true, foreign_key: true
  end
end
