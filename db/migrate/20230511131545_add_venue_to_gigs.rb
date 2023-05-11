class AddVenueToGigs < ActiveRecord::Migration[7.0]
  def change
    add_column :gigs, :venue, :string
  end
end
