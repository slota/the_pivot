FactoryGirl.define do
  factory :concert do
    date "2016-02-04"
    band "John Slota Band"
    logo "http://assets.rollingstone.com/assets/images/list/rsz-homepage-largedb5c5b0e-1354052522.jpg"
    price 1
    venue nil
    genre "MyString"
    url "MyString"
  end

  factory :user do
    username "John"
    password "pass"
  end

  factory :venue do
    name { Faker::Company.name }
    address "101 Super Sweet Place"
    city "Denver Obviously"
    state "Colorado"
    image { Faker::Company.logo}
    # image "http://musictour.eu/data//uploads/media/halls/893/f4a4def50c6367fdeafadf41efa9e387.jpg"
    description "If you haven't been here you are wrong"
  end
end
