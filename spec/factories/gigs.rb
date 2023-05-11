FactoryBot.define do
  factory :gig do
    name { 'name-' + (0...8).map { rand(65..90).chr }.join }
    venue { 'venue-' + (0...8).map { rand(65..90).chr }.join }
    date { Date.today }
    doors { DateTime.now }
    socials { '@insta-' + (0...8).map { rand(65..90).chr }.join }
  end
end
