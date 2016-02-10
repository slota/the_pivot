class Venues::ManagersController < ApplicationController
  def create
    user = User.find_by(username: params[:new_manager])
    ensure_business_admin(user)
    venue = Venue.find_by(url:params[:venue])
    venue.users << user
    redirect_to venue_path(venue.url)
  end

  def destroy
    venue = current_user.venues.find_by(url:params[:venue])
    manager = User.find(params[:id])
    venue.users.delete(manager)
    redirect_to venue_path(venue.url)
  end

  private

  def ensure_business_admin(user)
    user.update(role:1)
  end
end
