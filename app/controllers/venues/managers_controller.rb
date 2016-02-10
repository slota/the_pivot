class Venues::ManagersController < ApplicationController

  def create
    user = User.find_by(username: params[:new_manager])
    check_user(user)
  end

  def destroy
    venue = current_user.venues.find_by(url:params[:venue])
    manager = User.find(params[:id])
    venue.users.delete(manager)
    redirect_to venue_path(venue.url)
  end

  private

  def check_user(user)
    if user.nil?
      flash[:error] = "Please enter a valid registered user"
      redirect_to venue_path(url:params[:venue])
    else
      add_user_to_venue(user)
      redirect_to venue_path(url:params[:venue])
    end
  end

  def add_user_to_venue(user)
    ensure_business_admin(user)
    venue = Venue.find_by(url:params[:venue])
    venue.users << user
  end

  def ensure_business_admin(user)
    user.update(role:1)
  end
end
