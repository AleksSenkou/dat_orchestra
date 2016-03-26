class RepertoireController < ApplicationController
  def index
    @compositions = Composition.includes(:picture, members: :picture).all
  end
end
