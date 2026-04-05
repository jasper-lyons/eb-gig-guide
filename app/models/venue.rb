class Venue < ApplicationRecord
  has_many :gigs
  before_save :add_at_symbol_to_insta_tag


  def add_at_symbol_to_insta_tag
    return if insta_tag.blank?
    self.insta_tag = insta_tag.strip.prepend('@') unless insta_tag.strip.start_with?('@')
  end
end
