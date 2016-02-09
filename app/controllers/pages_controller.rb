class PagesController < ApplicationController
  def home
    @concerts = Concert.where(venue_id: Venue.where(status: 1))
  end

  def about
  end

  def bluebird
  end

  def edward
  end
end
