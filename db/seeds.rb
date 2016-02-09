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
      10.times do |i|
        Category.create(
          description: Faker::Address.state
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
        puts "User #{i.id} created"
      end
      User.create(username: "pa", password: "p", role: 2)
      User.create(username: "ba", password: "p", role: 1)
      User.create(username: "u", password: "p", role: 0)
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
      20.times do |i|
        Venue.create(
          name: "Venue #{i}",
          address: "Address #{i}",
          status: rand(0..1),
          city: "Denver",
          state: "CO",
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
          city: "Denver",
          state: "CO",
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
          date: Time.now,
          band: "Awesome Band no #{i}",
          logo: "http://assets.rollingstone.com/assets/images/list/rsz-homepage-largedb5c5b0e-1354052522.jpg",
          price: rand(30..300),
          genre: "Rock",
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
          genre: "Rock",
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
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Oil.create!([{name: "Lard"}, {name: "Coconut Oil"}, {name: "Avocado Oil"}])
#
# Chip.create!([
#   { name: "Grandma Utz Handcooked Original",
#     price: 6.99,
#     description: "Whole fresh potatoes, sliced and cooked in lard, with salt added. ",
#     oil_id: 1,
#     image_file_name: "/utz_lardoriginal.png"},
#   { name: "Jackson's Honest Sweet Potato",
#     price: 4.25,
#     description: "Wade with coconut oil. Nature's most nourishing oil. Non GMO
#     Project verified. Always kettle cooked in Colorado. Our goal at Jackson's
#     Honest Potato Chips is to bring the potato chip back to its humble and simple
#     roots by using the finest potatoes available and kettle frying them by hand
#     using organic coconut oil.",
#     oil_id: 2,
#     image_file_name: "/jacksons_sweetpotato.png"},
#   { name: "Dang Toasted Coconut Chips",
#     price: 10.79,
#     description: "Our toasted coconut chips are a delicious snack with all the
#     health benefits of coconut oil. They're so good, you'll say Dang! ",
#     oil_id: 2,
#     image_file_name: "/dang_coconutchips.png",
#     status: "retired" },
#   { name: "Grandma Utz Handcooked BBQ",
#     price: 6.99,
#     description: "Slightly thicker, un-rinsed potato slices, kettle-cooked in
#     lard in small batches at the best temperature for perfect crispness. Simply amazing!",
#     oil_id: 1,
#     image_file_name: "/utz_lardbbq.png"},
#   { name: "Boulder Canyon Kettle Cooked Sea Salt",
#     price: 3.28,
#     description: "Boulder Canyon Foods, an Inventure Foods brand, has expanded
#     its kettle-cooked potato chip line with the addition of Coconut Oil Kettle Cooked Potato Chips.",
#     oil_id: 2,
#     image_file_name: "/BoulderCanyonCoconut900.png"},
#   { name: "Boulder Canyon Sea Salt & Pepper",
#     price: 3.89,
#     description: "What’s better than our avocado oil chips? Adding a zesty pinch of salt combined with a kick of pepper for a perfect snack.",
#     oil_id: 3,
#     image_file_name: "/bouldercanyon_seasalt.png"},
#   { name: "Dang Coconut Chips Bacon",
#     price: 4.39,
#     description: "Coconut chips are a healthy snack with all the benefits of coconut oil. They're made from the copra (coconut meat), sliced out and toasted with sugar and salt. With abundant protein and fiber, it's okay to become addicted to this versatile snack.",
#     oil_id: 2,
#     image_file_name: "/dang_bacon.png"},
#   { name: "Jackson's Honest Salt and Vinegar",
#     price: 4.92,
#     description: "Made exclusively with organic potatoes and organic coconut oil and naturally gluten-free. We hope you will enjoy Jackson's Honest Potato Chips as much as we enjoy making them.",
#     oil_id: 2,
#     image_file_name: "/jacksons_saltandvinegar.png"},
#   { name: "Good Health Kettle Chips Sea Salt",
#     price: 3.39,
#     description: "These small-batch beauties are made with only three simple ingredients - real sliced potatoes, a dusting of sea salt and flavor-rich 100% Avocado Oil, which is known for its antioxidants and heart healthy monounsaturated fats so you can... Enjoy Being Good!",
#     oil_id: 3,
#     image_file_name: "/goodhealth_avocado.png"}
#   ])


  # User.create!([{username: "User", password: "Password"}, {username: "Admin", password: "Password", role: 1}])
  # Order.create!([{total_price: 20, user_id: 1}])
  # ChipOrder.create!([{chip_id: 1, quantity: 1, subtotal: 20, order_id: 1}])
  Seed.run
