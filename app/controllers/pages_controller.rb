class PagesController < ApplicationController
  skip_before_action :set_bg_color, only: :viewer

  def home
    @compositions =
      Composition.includes(:picture, :translations, members: :picture).first(9)
  end

  def about_us
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

  def viewer
    cookies[:viewer] ||= {
      value: true,
      expires: 1.year.from_now,
      domain: request.domain
    }

    redirect_to root_path
  end
end
