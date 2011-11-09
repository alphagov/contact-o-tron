class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_slimmer_header

  def set_slimmer_header
    headers['X-Slimmer-Template'] = 'admin'
  end
end
