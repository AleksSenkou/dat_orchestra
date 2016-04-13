module ApplicationHelper
  def nav_link(text, path, link_class, lng = nil)
    link_class += (current_page?(path) or locale.to_s == lng) ? ' current' : ''

    link_to text, path, class: link_class, data: { no_turbolink: true, locale: lng }
  end

  def home_page?
    current_page? root_path
  end

  def favicon_url
    @base_page.favicon.url(:medium)
  end

  def dance_logo_url
    @base_page.dance_logo.url
  end

  def logo_url
    @base_page.logo.url(:medium)
  end

  def logo_big_url
    @base_page.logo.url(:big)
  end

  def current_year
    Date.today.year
  end
end
