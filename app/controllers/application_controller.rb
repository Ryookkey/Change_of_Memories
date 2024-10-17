class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end
  
  # ゲストユーザーの判定
  def guest_user?
    current_user.email == 'guest@example.com'
  end
  
  helper_method :guest_user?
end
