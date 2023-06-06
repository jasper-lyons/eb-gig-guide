class ApplicationController < ActionController::Base
  before_action do
    Analytics::Event.create(
      path: request.path,
      method: request.method
    )
  end
end
