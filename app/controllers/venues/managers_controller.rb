class Venues::ManagersController < ApplicationController

  def create
    user = User.find_by(username: params[:new_manager])
    check_user(user)
  end

  def destroy
    venue = Venue.find_by(url: params[:venue])
    manager = User.find(params[:id])
    venue.users.delete(manager)
    redirect_to venue_path(venue.url)
  end

  private

  def find_venue
    if platform_admin? || business_admin?
      venue = Venue.find_by(url: params[:venue])
    else
      venue = current_user.venues.find_by(url:params[:venue])
    end
  end

  def check_user(user)
    if user.nil?
      flash[:error] = "Please enter a valid registered user"
      check_for_redirect
    else
      add_user_to_venue(user)
      check_for_redirect
    end
  end

  def check_for_redirect
    if platform_admin?
      redirect_to admin_venue_path(params[:venue])
    else
      redirect_to venue_path(url:params[:venue])
    end
  end

  def add_user_to_venue(user)
    check_business_admin(user)
    venue = Venue.find_by(url:params[:venue])
    venue.users << user
  end

  def check_business_admin(user)
    user.update(role:1) unless user.role == "platform_admin"
  end
end
