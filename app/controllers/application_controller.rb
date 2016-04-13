class ApplicationController < ActionController::Base
  before_action :load_base_page, :select_locale

  protect_from_forgery with: :exception

  private

  def load_base_page
    @base_page = BasePage.first
  end

  def select_locale
    country_code = request.location.country_code

    if cookies.has_key? :locale
      I18n.locale = cookies[:locale].to_sym
    elsif not ['BY', 'KZ', 'KG', 'TJ', 'RU', 'GE', 'UA'].include? country_code
      I18n.locale = :en
    else
      I18n.locale = I18n.default_locale
    end
  end
end
