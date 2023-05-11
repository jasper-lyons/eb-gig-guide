class AddSocialsToGigs < ActiveRecord::Migration[7.0]
  def change
    add_column :gigs, :socials, :string
  end
end
