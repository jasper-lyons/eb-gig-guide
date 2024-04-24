class CreateActs < ActiveRecord::Migration[7.0]
  def change
    create_table :acts do |t|
      t.string :name
      t.string :weblink

      t.timestamps
    end
  end
end
