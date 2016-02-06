FactoryGirl.define do
  factory :concert_order do
    concert nil
    order nil
    quantity 1
    subtotal 1.5
    price 1.5
  end
  factory :order do
    status "MyString"
    total_price 1.5
    user nil
    address "MyString"
  end


  factory :concert do
    date "2016-02-04"
    band "John Slota Band"
    logo "http://assets.rollingstone.com/assets/images/list/rsz-homepage-largedb5c5b0e-1354052522.jpg"
    price { rand(1..100) }
    venue nil
    genre "MyString"
    url "MyString"
  end

  factory :user do
    username "Dexter.Fowler"
    password "pass"
    picture "http://l1.yimg.com/bt/api/res/1.2/W_VfC5faktmNRESq5jg6fg--/YXBwaWQ9eW5ld3NfbGVnbztpbD1wbGFuZTtxPTc1O3c9NjAw/http://media.zenfs.com/en/person/Ysports/dexter-fowler-baseball-headshot-photo.jpg"
  end

  factory :venue do
    name { Faker::Company.name }
    address "101 Super Sweet Place"
    city "Denver Obviously"
    state "Colorado"
    image { Faker::Company.logo }
    # image "http://musictour.eu/data//uploads/media/halls/893/f4a4def50c6367fdeafadf41efa9e387.jpg"
    description "If you haven't been here you are wrong"
  end
end
