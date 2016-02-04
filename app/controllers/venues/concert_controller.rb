class Venues::ConcertController < ApplicationController
  def show
    @concert = Concert.find_by(url: params[:concert])
  end 
end 