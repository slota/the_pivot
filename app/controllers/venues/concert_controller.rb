class Venues::ConcertController < ApplicationController
  def show
    @concert = Concert.find_by(url: params[:concert])
  end 

  def destroy
    @concert = Concert.find_by(url: params[:concert])
    @venue = Venue.find_by(url: params[:venue])
    @concert.destroy
    redirect_to venue_path(@venue.url)
  end 
end 