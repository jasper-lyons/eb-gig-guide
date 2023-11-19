class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      if @subscriber.save
        format.html do
          flash[:notice] = 'Welcome to the community!'
          redirect_back(fallback_location: gigs_url)
        end
        format.json { render :show, status: :created, location: @subscriber }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
