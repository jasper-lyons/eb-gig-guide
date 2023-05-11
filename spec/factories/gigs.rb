FactoryBot.define do
  factory :gig do
    name { 'name-' + (0...8).map { rand(65..90).chr }.join }
    venue { 'venue-' + (0...8).map { rand(65..90).chr }.join }
    doors { DateTime.now }
  end
end
