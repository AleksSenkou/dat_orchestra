class PagesController < ApplicationController
  def home
    @featured_compositions = Composition.includes(:picture, members: :picture).first(9)
  end
end
