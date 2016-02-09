class NotificationController < ApplicationController
  
  def create
    TicketConfirmation.inform(current_user, params[:email]).deliver_later
    flash.now[:notice] = "Thank you for your purchase! \nPlease check your email for confirmation."
      if platform_admin?
        redirect_to admin_user_path(current_user.id)
      else
        redirect_to user_path(current_user.id)
      end
  end
end