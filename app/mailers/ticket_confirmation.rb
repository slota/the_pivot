class TicketConfirmation < ApplicationMailer
  def inform(user, client)
    @user = user
    mail(to: user.username, subject: "Concert tickets for #{user.username}.")
end

# class FriendNotifier < ApplicationMailer
#   def inform(user, friend_contact)
#     @user = user
#     mail(to: friend_contact, subject: "#{user.name} says you've changed.")
#   end
# end