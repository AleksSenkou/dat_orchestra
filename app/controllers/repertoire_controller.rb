class RepertoireController < ApplicationController
  def index
    preloaded_compositions = Composition.includes(:picture, members: :picture)

    @compositions = preloaded_compositions.paginate(page: params[:page], per_page: 15)
  end
end
