class RemoveDoorsFromVenue < ActiveRecord::Migration[7.0]
  def change
    remove_column :gigs, :doors
  end
end
