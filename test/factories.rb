FactoryGirl.define do
  factory :venue_user do
    venue nil
    user nil
  end
  factory :add_category_to_concert do
    
  end
  factory :category do
    description "MyString"
  end
  factory :concert_order do
    concert nil
    order nil
    quantity 1
    subtotal 1.5
    price 1.5
  end

  factory :order do
    status "Ordered"
    total_price 1.5
    user nil
    address "321 awesome"
  end


  factory :concert do
    date "2016-02-04"
    band "John Slota Band"
    price { rand(1..100) }
    venue nil
    logo nil
    genre "MyString"
    url "MyString"
  end

  factory :user do
    username { Faker::Company.name }
    password "pass"
  end

  factory :venue do
    name { Faker::Company.name }
    address "101 Super Sweet Place"
    city "Denver"
    state "Colorado"
    image nil
    description "If you haven't been here you are wrong"
  end
end
