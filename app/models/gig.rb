class Gig < ApplicationRecord
  def doors_time_only
    doors&.strftime('%l:%M%P')
  end
end
