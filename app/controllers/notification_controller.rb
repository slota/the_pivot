class NotificationController < ApplicationController

  def create
    TicketConfirmation.inform(current_user, params[:address]).deliver_later
    redirect
  end

  private
  def redirect
    if platform_admin?
      flash.now[:notice] = "Thank you for your purchase! \nPlease check your email for confirmation."
      redirect_to admin_user_path(current_user.id)
    else
      flash.now[:notice] = "Thank you for your purchase! \nPlease check your email for confirmation."
      redirect_to user_path(current_user.id)
    end
  end


end
