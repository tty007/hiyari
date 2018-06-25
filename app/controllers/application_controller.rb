class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #追加したカラムのストロングパラメータを追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  #ログイン後、マイページへリダイレクト
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :job, :gender])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :age, :job, :password])

  end

end
