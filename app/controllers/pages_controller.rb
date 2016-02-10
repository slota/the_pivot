class PagesController < ApplicationController
  respond_to :json
  def home
    @concerts = Concert.where(venue_id: Venue.where(status: 1)).paginate(page: params[:page], per_page: 8)
  end

  def about
  end

  def search
    # @concerts = Concert.where("band LIKE '%#{params[:search][:Band]}%'")
    # @concerts = Concert.active_venues.filter_band(params).filter_city(params).filter_date(params).paginate(page: params[:page], per_page: 8)
    # @concerts = Concert.active_venues.filter_date(params).filter_band(params).paginate(page: params[:page], per_page: 8)
    @concerts = Concert.active_venues
    @concerts = @concerts.band(params) if params[:search][:Band]
  @concerts = @concerts.date(params) if params[:search][:Date]
@concerts = @concerts.genre(params) if params[:search][:Genre]
@concerts = @concerts.paginate(page: params[:page], per_page: 8)
                       #  .city(params)
    render :home
  end

  private

      # def paginate
      #   paginate(page: params[:page], per_page: 8)
      # end
end
