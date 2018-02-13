# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :output_job do
  	association :submission
    association :output
    success      true
    result      ({"msg" => "all good"})
  	id					{Faker::Lorem.characters([8,14])}
  end
end
