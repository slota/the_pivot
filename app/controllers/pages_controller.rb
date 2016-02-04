class PagesController < ApplicationController
  def home
    @concerts = Concert.all
  end

  def about
  end

  def bluebird
  end

  def edward
  end
end
