class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by(url: params[:venue])
  end

  def index
    @venues = current_user.venues.to_a
    render file: 'public/404' unless current_user.business_admin?
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create(venue_params)
    current_user.venues << @venue
    flash[:sucess] = "Request sent for approval"
    redirect_to venues_path
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :image, :city, :state, :address, :description)
  end
end
