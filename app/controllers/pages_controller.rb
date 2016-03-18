class PagesController < ApplicationController
  def home
    @featured_compositions = Composition.first(6)
  end
end
