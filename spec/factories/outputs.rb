# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :output do
		association :owner, factory: :user
    forms {[create(:form)]}
    name		"facebook"
    configuration ({"A"=>"b"})
    type	"SlackOutput"
  	id					{Faker::Lorem.characters([8,14])}
  end
end
