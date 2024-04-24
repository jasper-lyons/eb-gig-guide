class CreateActGigs < ActiveRecord::Migration[7.0]
  def change
    create_table :act_gigs do |t|

      t.timestamps
    end
  end
end
