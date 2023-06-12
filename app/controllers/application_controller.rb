class ApplicationController < ActionController::Base
  before_action do
    Analytics::Event.create(
      path: request.path,
      method: request.method,
      ip_address: request.remote_ip,
      user_agent: request.user_agent
    )
  end
end
