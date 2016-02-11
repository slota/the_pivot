class ConcertsController < ApplicationController
  def edit
    @concert = Concert.find_by(url: params[:id])
  end

  def update
    concert = Concert.find(params[:id])
    if concert.update(concert_params)
      redirect(concert)
    # else
    #   flash[:error] = concert.errors.full_messages.join(", ")
    #   render :edit
    end
  end

  private

  def redirect(concert)
    if platform_admin?
      redirect_to admin_venue_path(concert.venue.url)
    else
      redirect_to venue_path(concert.venue.url)
    end
  end

  def concert_params
    params.require(:concert).permit(:date, :band, :logo, :price, :genre)
  end
end
