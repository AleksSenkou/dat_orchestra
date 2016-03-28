class RepertoireController < ApplicationController
  def index
    @compositions = Composition.includes(:picture, members: :picture).paginate(page: params[:page], per_page: 18)
  end
end
