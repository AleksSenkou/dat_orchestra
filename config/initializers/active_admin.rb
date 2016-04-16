ActiveAdmin.setup do |config|
  config.skip_before_filter :load_base_page

  config.site_title = "Dat-arkestr"
  config.site_title_link = "/"

  config.authentication_method = :authenticate_admin_user!

  config.current_user_method = :current_admin_user

  config.logout_link_path = :destroy_admin_user_session_path

  config.comments = false

  config.batch_actions = true

  config.localize_format = :long

  # config.breadcrumb = false

  # To load a stylesheet:
  #   config.register_stylesheet 'my_stylesheet.css'

  #   config.namespace :admin do |admin|
  #     admin.build_menu :utility_navigation do |menu|
  #       menu.add label: "My Great Website", url: "http://www.mygreatwebsite.com", html_options: { target: :blank }
  #       admin.add_logout_button_to_menu menu
  #     end
  #   end
  #
  # If you wanted to add a static menu item to the default menu provided:
  #
  #   config.namespace :admin do |admin|
  #     admin.build_menu :default do |menu|
  #       menu.add label: "My Great Website", url: "http://www.mygreatwebsite.com", html_options: { target: :blank }
  #     end
  #   end

  # == Pagination
  # config.default_per_page = 30
  # config.max_per_page = 10_000

  # == Filters
  # config.filters = true
end
