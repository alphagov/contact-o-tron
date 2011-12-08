class ApplicationController < ActionController::Base
  protect_from_forgery
  include GDS::SSO::ControllerMethods

  before_filter :set_slimmer_header

  def set_slimmer_header
    headers['X-Slimmer-Template'] = 'admin'
  end
end
