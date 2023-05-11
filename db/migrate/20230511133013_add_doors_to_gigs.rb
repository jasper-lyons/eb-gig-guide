class AddDoorsToGigs < ActiveRecord::Migration[7.0]
  def change
    add_column :gigs, :doors, :datetime
  end
end
