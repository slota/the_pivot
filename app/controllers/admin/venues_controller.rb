class Admin::VenuesController < Admin::BaseController
  #have before_action :require_platform_admin in base controller

  # respond_to :json
  #
  # def index
  #   respond_with Venue.all
  # end

  def index
    @venues = Venue.all
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create(venue_params)
    current_user.venues << @venue
    flash[:success] = "Request sent for approval"
    redirect_to admin_venues_path
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    # @venue = Venue.find(params[:id])
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
