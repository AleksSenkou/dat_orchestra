class RepertoireController < ApplicationController
  def index
    preloaded_compositions =
      Composition.includes(:picture, :translations, members: :picture)

    @compositions = preloaded_compositions.paginate(page: params[:page], per_page: 15)
  end
end
