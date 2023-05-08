class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def render_access_denied
    render :file => "#{Rails.root}/public/403.html",  :status => 403, layout: false, status: :forbidden
  end
end
