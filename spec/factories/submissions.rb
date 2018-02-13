# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :submission do
  	association :form
  	path				"/test"
    content			({abc: "ced"})
  	id					{Faker::Lorem.characters([8,14])}
  end
end
