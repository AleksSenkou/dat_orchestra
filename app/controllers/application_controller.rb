class ApplicationController < ActionController::Base
  before_action :load_base_page

  protect_from_forgery with: :exception

  private

  def load_base_page
    @base_page = BasePage.first
  end
end
