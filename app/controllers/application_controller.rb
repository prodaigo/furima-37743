class ApplicationController < ActionController::Base
  before_action :basic_auth  # メソッド呼び出し
  before_action :configure_permitted_parameters, if: :devise_controller?  #deviseに関するコントローラーの処理であれば、メソッド呼び出し

  private # クラス外から呼び出すことができないメソッドを定義

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password| # Basic認証を実装するためのメソッド
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 任意のusernameとpassword指定
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday])  # deviseのUserモデルにパラメーターを許可
  end
end
