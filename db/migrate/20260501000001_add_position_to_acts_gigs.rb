class AddPositionToActsGigs < ActiveRecord::Migration[7.0]
  def change
    add_column :acts_gigs, :position, :integer, default: 0, null: false
  end
end
