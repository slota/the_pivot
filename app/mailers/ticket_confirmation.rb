require 'barby'
require 'barby/barcode/EAN13'
require 'barby/outputter/ascii_outputter'
require 'barby/outputter/html_outputter'


class TicketConfirmation < ApplicationMailer
  def inform(user, client)
    @user = user
    @orders = @user.orders.all
    @barcode = Barby::EAN13.new('012345678912')
    @barcode_for_html = Barby::HtmlOutputter.new(@barcode)
    mail(to: client, subject: "Concert tickets for #{user.username}.")
  end
end