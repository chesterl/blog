FactoryGirl.define do
  factory :post do
    title 'This is a valid title'
    body 'This is a valid body'

    factory :invalid_post do
      title nil
    end
  end


end