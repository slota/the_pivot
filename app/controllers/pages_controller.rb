class PagesController < ApplicationController
  respond_to :json
  def home
    @concerts = Concert.where(venue_id: Venue.where(status: 1)).paginate(page: params[:page], per_page: 8)
  end

  def about
  end
end
