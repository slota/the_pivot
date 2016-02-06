class ConcertOrder < ActiveRecord::Base
  belongs_to :concert
  belongs_to :order
end
