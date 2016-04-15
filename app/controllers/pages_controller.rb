class PagesController < ApplicationController
  def home
    @compositions =
      Composition.includes(:picture, :translations, members: :picture).first(9)
  end

  def set_locale
    if I18n.available_locales.map(&:to_s).include? params[:locale]
      cookies[:locale] = {
        value: params[:locale],
        expires: 10.year.from_now,
        domain: request.domain
      }
    end

    render nothing: true
  end
end
