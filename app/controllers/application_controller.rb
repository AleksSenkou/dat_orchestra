class ApplicationController < ActionController::Base
  before_action :load_base_page, :select_locale

  protect_from_forgery with: :exception

  private

  def load_base_page
    @base_page = BasePage.first
  end

  def select_locale
    available = %w(ru en en-US)
    preferred_language = http_accept_language.preferred_language_from(available)

    if cookies.has_key? :locale
      I18n.locale = cookies[:locale].to_sym
    elsif preferred_language.present?
      I18n.locale = preferred_language
    else
      I18n.locale = I18n.default_locale
    end
  end
end
