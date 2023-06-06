class CreateAnalyticsEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :analytics_events do |t|
      t.string :path
      t.string :method

      t.timestamps
    end
  end
end
