FactoryBot.define do
  factory :venue do
    name { "MyString" }
    insta_tag { '@insta-' + (0...8).map { rand(65..90).chr }.join }
  end
end
