class Venues::ConcertController < ApplicationController
  def show
    @concert = Concert.find_by(url: params[:concert])
  end

  def new
    @concert = Concert.new
  end

  def create
    venue = Venue.find_by(url: params[:venue])
    if category = Category.find_by(description: params[:concert][:genre].downcase)
      concert =  Concert.create(concert_params)
      concert.update(category: category)
      venue.concerts << concert
      redirect(venue)
    else
      flash[:error] = 'Introduce a valid genre'
      redirect_to venue_new_concert_path(venue.url)
    end
  end

  def destroy
    concert = Concert.find_by(url: params[:concert])
    venue = Venue.find_by(url: params[:venue])
    concert.destroy
    redirect(venue)
  end

  private

  def redirect(venue)
    if platform_admin?
      redirect_to admin_venue_path(venue.url)
    else
      redirect_to venue_path(venue.url)
    end
  end

  def concert_params
    params.require(:concert).permit(:date, :band, :logo, :price)
  end
end
