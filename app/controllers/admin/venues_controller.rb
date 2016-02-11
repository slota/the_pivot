class Admin::VenuesController < ApplicationController

  def index
    @venues = Venue.paginate(page: params[:page], per_page: 8)
  end

  def new
    @venue = Venue.new
  end

  def show
    @venue = Venue.find_by(url: params[:id])
    @user = User.find_by(id: @venue.user_id)
  end

  def create
    @venue = Venue.create(venue_params)
    current_user.venues << @venue
    flash[:success] = "Request sent for approval to #{current_user.username}"
    redirect_to admin_venues_path
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    venue = Venue.find_by(id: params[:id])
    venue.update_attributes(venue_params)
    venue.send("#{params[:status]}!")
    flash[:success] = "#{venue.name} Updated!"
    redirect_to admin_venues_path
  end

  private

  def venue_params
    params.require(:venue).permit(:name,
                                  :image,
                                  :city,
                                  :state,
                                  :address,
                                  :description,
                                  :status)
  end
end
