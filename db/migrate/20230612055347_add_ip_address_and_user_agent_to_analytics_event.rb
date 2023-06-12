class AddIpAddressAndUserAgentToAnalyticsEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :analytics_events, :ip_address, :string
    add_column :analytics_events, :user_agent, :string
  end
end
