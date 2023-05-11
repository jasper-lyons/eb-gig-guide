class CreateGigs < ActiveRecord::Migration[7.0]
  def change
    create_table :gigs do |t|
      t.string :name

      t.timestamps
    end
  end
end
