module HeaderHelper
  def render_sass(file)
    text = render("/layouts/#{ file }")
    view_context = controller.view_context

    engine = Sass::Engine.new(text, {
      syntax: :sass,
      cache: false,
      read_cache: false,
      style: :compressed,
      sprockets:  {
        context:     view_context,
        environment: view_context.assets_environment
      }
    })
    raw engine.render
  end

  def heading
    uppercase_letters = @base_page.heading.scan(/\p{Upper}/).join
    normal_letters = @base_page.heading.delete uppercase_letters

    content_tag(:span, uppercase_letters, class: 'header-uppercase') +
    content_tag(:span, normal_letters, class: 'header-normal')
  end

  def subheading
    if home_page?
      @base_page.subheading
    elsif controller_name == 'gallery_items'
      t('.gallery')
    else
      t(".#{ controller_name }")
    end.capitalize
  end
end
