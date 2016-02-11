class CartConcertsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    concert = Concert.find_by(url: params[:format])
    @cart.add_concert(concert.id, params[:order][:quantity])
    session[:cart] = @cart.contents
    flash[:notice] = "Added #{view_context.link_to(concert.band, venue_concert_path(concert.venue.url, concert.url))} to cart."
    redirect_to cart_path
  end

  def index
    @concerts = @cart.cart_concerts
  end

  def destroy
    concert = Concert.find_by(url: params[:id])
    @cart.remove_concert(concert)
    flash[:notice] = "Successfully removed #{view_context.link_to(concert.band, venue_concert_path(concert.venue.url, concert.url))} from your cart."
    redirect_to root_path
  end

end
