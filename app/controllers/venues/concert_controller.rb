class Venues::ConcertController < ApplicationController
  def show
    @concert = Concert.find_by(url: params[:concert])
  end

  def new
    @concert = Concert.new
  end

  def create
    venue = Venue.find_by(url: params[:venue])
    venue.concerts << Concert.create(concert_params)
    redirect_to venue_path(venue.url)
  end

  private
  def concert_params
    params.require(:concert).permit(:date, :band, :logo, :price, :genre)
  end
end
