# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :form do
		association :user
  	title 		"test form"
  	id					{Faker::Lorem.characters([8,14])}
  end
end
