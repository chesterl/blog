FactoryGirl.define do
  factory :comment do
    association :post
    name { Faker::Name.name }
    body 'I love this post'

  end
end
