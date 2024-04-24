class CreateActsGigs < ActiveRecord::Migration[7.0]
  def change
    create_table :act_gig do |t|
      t.references :act, null: true, foreign_key: true
      t.references :gig, null: true, foreign_key: true

      t.timestamps
    end
  end
end
