class AddSocialsToVenue < ActiveRecord::Migration[7.0]
  def change
      add_column :venues, :insta_tag, :string
  end
end
