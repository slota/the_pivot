class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by(url: params[:venue])
    @concerts = @venue.concerts.paginate(page: params[:page], per_page: 8)
  end

  def index
    @venues = (current_user.venues + current_user.managed_venues).uniq
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      current_user.venues << @venue
      flash[:success] = "Request sent for approval"
      redirect_to venues_path
    else
      flash[:error] = @venue.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @venue = Venue.find_by(url: params[:venue])
  end

  def update
    venue = Venue.find_by(id: params[:venue])
    if venue.update(update_params)
      flash[:success] = "#{venue.name} Updated!"
      redirect_to venues_path
      # redirect
    else
      flash[:error] = venue.errors.full_messages.join(", ")
      render :edit
    end
  end

  private
  #
  # def redirect
  #   if platform_admin?
  #     redirect_to admin_venues_path
  #   else
  #     redirect_to venues_path
  #   end
  # end

  def venue_params
    params.require(:venue).permit(:name, :image, :city, :state, :address, :description)
  end

  def update_params
    params.permit(:name, :image, :city, :state, :address, :description)
  end
end
