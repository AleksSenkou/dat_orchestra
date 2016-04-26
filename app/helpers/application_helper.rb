module ApplicationHelper
  def nav_link(text, path, link_class)
    link_class += current_page?(path) ? ' current' : ''

    link_to text, path, class: link_class, data: { no_turbolink: true }
  end

  def locale_link(text, link_class, lng)
    link_class += locale.to_s.include?(lng) ? ' current' : ''

    content_tag :span, text, class: link_class, data: { locale: lng }
  end

  def home_page?
    current_page? root_path
  end

  def contacts_page?
    current_page? contacts_path
  end

  def favicon_url
    @base_page.favicon.url(:medium)
  end

  def dance_logo_url
    @base_page.dance_logo.url(:medium)
  end

  def dance_logo_big_url
    @base_page.dance_logo.url(:big)
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
