class PagesController < ApplicationController
  def home
    @compositions = Composition.includes(:picture, members: :picture).first(9)
  end

  def set_locale
    cookies[:locale] = {
      value: params[:locale],
      expires: 10.year.from_now,
      domain: request.domain
    }

    render nothing: true
  end
end
