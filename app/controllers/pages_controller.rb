class PagesController < ApplicationController
  respond_to :json
  def home
    @concerts = Concert.where(venue_id: Venue.where(status: 1)).paginate(page: params[:page], per_page: 5)
  end

  def about
  end

  def search
    @concerts = Concert.active_venues
                       .band(params[:search][:Band])
                       .date(params[:search][:Date])
                       .city(params[:search][:City])
                       .genre(params[:search][:Genre])
                       .paginate(page: params[:page], per_page: 8)
    render :home
  end
end
