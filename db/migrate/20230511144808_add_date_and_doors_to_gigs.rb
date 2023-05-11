class AddDateAndDoorsToGigs < ActiveRecord::Migration[7.0]
  def change
    add_column :gigs, :date, :date
    add_column :gigs, :doors, :time
  end
end
