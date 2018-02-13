# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :form, class: Form do
		association :owner
  	name 		"test form"
    website "www.website.com"
  	id					{Faker::Lorem.characters([8,14])}
  end
end
