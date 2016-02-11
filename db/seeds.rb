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
      categories = %w(rock blues ska metal pop rap country indie hip-hop electronic`)
      categories.each do |genre|
        Category.create(
          description: genre
          )
      end
    end

    def self.generate_users
      100.times do |i|
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
      cities = %w(Denver Alicante Boulder Golden)
      20.times do |i|
        Venue.create(
          name: Faker::Hipster.words(1).join(" ").capitalize,
          address: "#{i} Street Mall",
          status: rand(0..1),
          city: cities.sample,
          state: Faker::Address.state,
          image: "http://cdn.partyearth.com/photos/7cfff5c7cccaf6b2d795f9fa9cb161b1/luz-de-gas_s345x230.jpg?1375050702",
          description: " #{i}",
          user: User.find_by(username: "ba").venues.sample,
        )
        puts "Venue #{i} created"
      end

      Venue.create(
        name: "Red Rocks Amphitheatre",
        address:  "18300 W Alameda Pkwy",
        city: "Morrison",
        state: "CO",
        status: 1,
        image: 'http://www.natesiggard.com/wp/wp-content/uploads/2013/03/20110816-RedRocksSunset-640x426.jpg',
        description: "Welcome to Red Rocks Park & Amphitheatre, one of the greatest entertainment venues in the world.",
        user: User.find_by(username: "andrew@turing.io"))
        puts "Created Red Rocks"

      Venue.create(
        name: "Bluebird",
        address:  "3317 E. Colfax Ave",
        city: "Denver",
        state: "CO",
        status: 1,
        image: 'http://musictour.eu/data//uploads/media/halls/893/f4a4def50c6367fdeafadf41efa9e387.jpg',
        description: "The Bluebird Theater was built in 1913.",
        user: User.find_by(username: "andrew@turing.io"))
        puts "Created Bluebird"
      
      Venue.create(
        name: "Ogden",
        address:  "935 E Colfax Ave",
        city: "Denver",
        state: "CO",
        status: 1,
        image: 'http://www.rantlifestyle.com/wp-content/uploads/2014/06/9.-Ogden-Theatre.jpg',
        description: "The Ogden Theatre is a music venue and former movie theater in Denver, Colorado, United States.",
        user: User.find_by(username: "andrew@turing.io"))
        puts "Created Ogden"


      3.times do |i|
        Venue.create(
          name: "Ba's Venue #{i}",
          address: "#{i} Street Mall",
          city: cities.sample,
          state: Faker::Address.state,
          image: "http://cdn.partyearth.com/photos/7cfff5c7cccaf6b2d795f9fa9cb161b1/luz-de-gas_s345x230.jpg?1375050702",
          description: "The interior makes use of warm, natural materials such as alder trim and ceiling beams",
          user: User.find_by(username: "andrew@turing.io")
        )
        puts "BA's venue #{i} created"
      end
    end

    def self.generate_concerts
      500.times do |i|
        Concert.create(
          date: Faker::Date.forward(15),
          band: Faker::Hipster.words(2).join(" "),
          logo: "http://assets.rollingstone.com/assets/images/list/rsz-homepage-largedb5c5b0e-1354052522.jpg",
          price: rand(40..150),
          venue: Venue.offset(rand(Venue.count-1)).first,
          category: Category.offset(rand(Category.count-1)).first
        )
        puts "Concert #{i} created"
      end

      10.times do |i|
        Concert.create(
          date: Faker::Date.forward(15),
          band: Faker::Hipster.words(2).join(" "),
          logo: "http://i.dailymail.co.uk/i/pix/2009/09/08/article-1212041-06445491000005DC-882_306x360.jpg",
          price: rand(30..300),
          category: Category.offset(rand(Category.count-1)).first,
          venue: User.find_by(username: "andrew@turing.io").venues.sample
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
        concert = Concert.offset(rand(Concert.count-1)).first
        ConcertOrder.create(
          concert: concert,
          order: Order.offset(rand(Order.count-1)).first,
          quantity: quantity,
          subtotal: quantity * concert.price,
        )
        puts "Order #{i} created"
      end
    end

    def self.generate_orders
      1000.times do |i|
        Order.create(
          user: User.offset(rand(User.count-1)).first,
          status: "Purchased",
          address: Faker::Internet.email
        )
        puts "Order #{i} created"
      end
    end
end
Seed.run
