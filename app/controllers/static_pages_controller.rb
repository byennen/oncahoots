class StaticPagesController < ActionController::Base
  before_filter :authenticate_user!
  layout 'static'
end
