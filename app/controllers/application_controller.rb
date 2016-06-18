class ApplicationController < ActionController::Base
  DEFAULT_BG_COLOR = '#f7f7f7'

  before_action :load_base_page, :set_bg_color, :select_locale

  protect_from_forgery with: :exception

  private

  def load_base_page
    @base_page = BasePage.first
  end

  def set_bg_color
    @bg_color = portfolio_viewer ? DEFAULT_BG_COLOR : @base_page.bg_color
  end

  def portfolio_viewer
    cookies[:viewer] ||= {
      value: request.referer.include?('upwork'),
      expires: 1.year.from_now,
      domain: request.domain
    }
  end.to_b

  def select_locale
    available = %w(ru en en-US)
    preferred_language = http_accept_language.preferred_language_from(available)

    I18n.locale = if cookies.has_key? :locale
      cookies[:locale].to_sym
    elsif preferred_language.present?
      preferred_language
    else
      I18n.default_locale
    end
  end
end
