class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top ,:about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if user_signed_in?
      flash[:notice] = "ログイン"
      root_path(resource)
    else
      flash[:notice] = "管理者ログイン"
      admin_root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:id, :email, :last_name, :first_name, :kana_last_name, :kana_first_name, :handle_name, :postcode, :address, :phone_number, :is_deleted, :prefecture_code, :address_city, :address_street, :address_building, :introduction])
    end
end
