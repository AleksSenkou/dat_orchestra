class PagesController < ApplicationController
  def home
    @featured_compositions = Composition.includes(:picture, members: :picture).first(6)
  end
end
