class PagesController < ApplicationController
  respond_to :json
  def home
    # @concerts = Concert.paginate(page: params[:page], per_page: 8)
    @concerts = Concert.all
    # respond_with Concert.all
  end

  def about
  end
end
