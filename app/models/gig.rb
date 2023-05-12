class Gig < ApplicationRecord
  def doors_time_only
    doors&.strftime('%l:%M%P')
  end

  def date
    # This is to faciliate the different between dev and prod
    # in dev we use sqlite which stores dates as strings, in prod
    # we use postgres which stores dates as datetimes
    return Date.parse(self[:date]) if self[:date].is_a?(String)

    self[:date]
  end
end
