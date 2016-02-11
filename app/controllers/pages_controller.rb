class PagesController < ApplicationController
  respond_to :json
  
  def home
    if params[:search]
      filter_concerts(params)
    else
      @concerts = Concert.where(venue_id: Venue.where(status: 1)).order(:date).paginate(page: params[:page], per_page: 5)
    end
  end

  def about
  end

  private

  def filter_concerts(params)
    @concerts = Concert.active_venues
                 .band(params[:search][:Band])
                 .date(params[:search][:Date])
                 .city(params[:search][:City])
                 .genre(params[:search][:Genre])
                 .order(:date)
                 .paginate(page: params[:page], per_page: 15)
  end

end
