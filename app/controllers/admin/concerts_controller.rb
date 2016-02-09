class ConcertsController < ApplicationController
  def edit
    @concert = Concert.find_by(url: params[:id])
  end

  def update
    concert = Concert.find(params[:id])
    concert.update(concert_params)
    redirect_to venue_path(concert.venue.url)
  end

  private

  def concert_params
    params.require(:concert).permit(:date, :band, :logo, :price, :genre)
  end
end