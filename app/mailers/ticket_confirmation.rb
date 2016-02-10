class TicketConfirmation < ApplicationMailer
  def inform(user, client)
    @user = user
    @orders = @user.orders.all
    mail(to: client, subject: "Concert tickets for #{user.username}.")
  end
end