class Gig < ApplicationRecord
  belongs_to :venue, optional: true
  has_many :acts_gig
  has_many :acts, -> { order("acts_gigs.position ASC") }, through: :acts_gig

  before_save :add_at_symbol_to_socials

  def doors_time_only
    doors&.strftime('%l:%M%P')
  end

  def add_at_symbol_to_socials
    return if socials.blank?
    tagged_socials = socials.scan(/\w+/).map { 
      |social| social.start_with?('@') ? social : "@#{social}"
    }
    self.socials = tagged_socials.join(' ')
  end

  def date
    # This is to faciliate the different between dev and prod
    # in dev we use sqlite which stores dates as strings, in prod
    # we use postgres which stores dates as datetimes
    return Date.parse(self[:date]) if self[:date].is_a?(String)

    self[:date]
  end
end
