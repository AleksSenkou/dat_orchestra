module HeaderHelper
  def heading
    @base_page.heading
  end

  def subheading
    if home_page?
      @base_page.subheading
    elsif controller_name == 'gallery_items'
      'gallery'
    elsif action_name == 'contacts'
      'contacts'
    else
      controller_name
    end.capitalize
  end
end
