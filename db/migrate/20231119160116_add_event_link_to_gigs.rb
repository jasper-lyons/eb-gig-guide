class AddEventLinkToGigs < ActiveRecord::Migration[7.0]
  def change
    add_column :gigs, :event_link, :string
  end
end
