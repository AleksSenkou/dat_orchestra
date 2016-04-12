class RidersController < ApplicationController
  def index
    @riders = Rider.all
  end
end
