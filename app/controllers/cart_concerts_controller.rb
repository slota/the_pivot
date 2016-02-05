class CartConcertsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    concert = Concert.find(params[:concert_id])
    @cart.add_concert(concert.id)
    session[:cart] = @cart.contents
    flash[:notice] = "Added #{view_context.link_to(concert.name, concert_path(concert.slug))} to cart."
    redirect_to concerts_path
  end

  def index
    binding.pry

    @concerts = current_user.concerts
  end

  def update
    concert = Concert.find(params[:id])
    @cart.add_or_subtract_concert(params[:edit_action], concert)
    if @cart.remove_notice?(params[:edit_action])
      flash[:notice] = "Successfully removed #{view_context.link_to(concert.name, concert_path(concert.slug))} from your cart."
    end
    @concerts = @cart.cart_concerts
    redirect_to cart_concerts_path
  end

  def destroy
    concert = Concert.find(params[:id])
    @cart.remove_concert_completely(concert.id)
    flash[:notice] = "Successfully removed #{view_context.link_to(concert.name, concert_path(concert.slug))} from your cart."
    redirect_to cart_concerts_path
  end
end
