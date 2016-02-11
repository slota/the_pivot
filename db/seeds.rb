class Seed
    def self.run
      Seed.generate_users
      Seed.generate_business_admins
      Seed.generate_venues
      Seed.generate_categories
      Seed.generate_concerts
      Seed.generate_orders
      Seed.generate_concert_orders
      Seed.generate_order_price
    end

    def self.generate_categories
      categories = %w(rock blues ska metal pop rap country indie)
      10.times do |i|
        Category.create(
          description: categories.sample
          )
      end
    end

    def self.generate_users
      10.times do |i|
        User.create(
        username: "user#{i}",
        password: "p",
        role: 0
        )
        puts "User #{i} created"
      end
      User.create(username: "pa", password: "p", role: 2)
      User.create(username: "ba", password: "p", role: 1)
      User.create(username: "u",  password: "p", role: 0)
      User.create(username: "josh@turing.io", password: "password", role: 0, image: "http://photos3.meetupstatic.com/photos/member/9/3/f/a/highres_223357882.jpeg")
      User.create(username: "andrew@turing.io", password: "password", role: 1, image: "https://pbs.twimg.com/profile_images/667068239986323456/5gFicGr4.jpg")
      User.create(username: "jorge@turing.io", password: "password", role: 2, image: "http://photos2.meetupstatic.com/photos/member/b/f/7/1/highres_242869009.jpeg")
    end

    def self.generate_business_admins
      @bas = []
      5.times do |i|
        ba = User.create(
        username: "ba#{i}",
        password: "p",
        role: 1
        )
        @bas << ba
        puts "BA #{i} created"
      end
    end

    def self.generate_venues
      cities = %w(denver alicante boulder camino)
      20.times do |i|
        Venue.create(
          name: "Venue #{i}",
          address: "Address #{i}",
          status: rand(0..1),
          city: cities.sample,
          state: Faker::Address.state,
          # image: "http://musictour.eu/data//uploads/media/halls/893/f4a4def50c6367fdeafadf41efa9e387.jpg",
          description: "Long and boring description #{i}",
          user: @bas.sample
        )
        puts "Venue #{i} created"
      end

      3.times do |i|
        Venue.create(
          name: "Ba's Venue #{i}",
          address: "Ba's Address #{i}",
          city: cities.sample,
          state: Faker::Address.state,
          # image: "http://musictour.eu/data//uploads/media/halls/893/f4a4def50c6367fdeafadf41efa9e387.jpg",
          description: "Long and boring description #{i}",
          user: User.find_by(username: "ba")
        )

        puts "BA's venue #{i} created"
      end
    end

    def self.generate_concerts
      50.times do |i|
        Concert.create(
          date: Faker::Date.forward(15),
          band: "Awesome Band no #{i}",
          logo: "http://assets.rollingstone.com/assets/images/list/rsz-homepage-largedb5c5b0e-1354052522.jpg",
          price: rand(30..300),
          # genre: "Rock",
          venue: Venue.offset(rand(Venue.count-1)).first,
          category: Category.offset(rand(Category.count-1)).first
        )
        puts "Concert #{i} created"
      end

      10.times do |i|
        Concert.create(
          date: Time.now,
          band: "Ba's Awesome Band no #{i}",
          logo: "http://assets.rollingstone.com/assets/images/list/rsz-homepage-largedb5c5b0e-1354052522.jpg",
          price: rand(30..300),
          category: Category.offset(rand(Category.count-1)).first,
          # genre: "Rock",
          venue: User.find_by(username: "ba").venues.sample
        )
        puts "BA's Concert #{i} created"
      end
    end

    def self.generate_order_price
      Order.all.each do |i|
        i.update(total_price: i.concert_orders.inject(0) {|sum,i| sum + i.subtotal})
        puts "Order #{i} updated"
      end
    end

    def self.generate_concert_orders
      20.times do |i|
        quantity = rand(1..6)
        price = rand(1..100)
        ConcertOrder.create(
          concert: Concert.offset(rand(Concert.count-1)).first,
          order: Order.offset(rand(Order.count-1)).first,
          quantity: quantity,
          subtotal: quantity * price,
          price: price
        )
        puts "Order #{i} created"
      end
    end

    def self.generate_orders
      10.times do |i|
        Order.create(
          user: User.offset(rand(User.count-1)).first,
          status: "Purchased"
        )
        puts "Order #{i} created"
      end
    end
end
Seed.run
