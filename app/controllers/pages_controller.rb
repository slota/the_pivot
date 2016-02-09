class PagesController < ApplicationController
  def home
    @concerts = Concert.paginate(page: params[:page], per_page: 8)
  end

  def about
  end
end
