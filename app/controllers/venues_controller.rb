class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by(url: params[:venue])
  end
end
