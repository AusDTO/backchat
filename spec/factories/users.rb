# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	name 			{Faker::Name.name}
  	email 		{Faker::Internet.email}
  	admin			false
		password 	{Faker::Internet.password(min_length = 8)}
    approved  true

		factory :owner do
			admin 		true
    end
    factory :admin_user do
			admin 		true
		end
  end
end
