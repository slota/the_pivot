class Admin::VenuesController < Admin::BaseController
  #have before_action :require_platform_admin in base controller
  def index 
    @venues = Venue.all
  end 

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create(venue_params)
    flash[:success] = "Thank you for your submission. Your venue will be activated once we review your submission!"
    redirect_to admin_venues_path
  end 

  private

  def venue_params
    params.require(:venue).permit(:name,
                                  :image, 
                                  :city,
                                  :state,
                                  :address,
                                  :description)
  end 
end 
