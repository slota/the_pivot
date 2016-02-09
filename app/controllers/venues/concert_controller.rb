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
    if platform_admin?
      redirect_to admin_venue_path(venue.url)
    else
      redirect_to venue_path(venue.url)
    end
  end

  def destroy
    @concert = Concert.find_by(url: params[:concert])
    @venue = Venue.find_by(url: params[:venue])
    @concert.destroy
    redirect_to venue_path(@venue.url)
  end

  private

  def concert_params
    params.require(:concert).permit(:date, :band, :logo, :price, :genre)
  end
end
