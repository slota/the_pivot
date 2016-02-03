class Venue < ActiveRecord::Base

  enum status: %w(Pending Approved Declined)
end 