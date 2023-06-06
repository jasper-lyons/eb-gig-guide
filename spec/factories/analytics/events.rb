FactoryBot.define do
  factory :analytics_event, class: 'Analytics::Event' do
    path { 'MyString' }
    add_attribute(:method) { 'MyString' }
  end
end
