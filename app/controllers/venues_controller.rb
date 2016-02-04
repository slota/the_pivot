class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by(url: params[:venue])
  end

  def index
    render file: 'public/404' unless current_user.role == ('business_admin' || 'platform_admin')
    @venues = current_user.venues.to_a
  end
end
