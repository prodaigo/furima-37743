class ApplicationController < ActionController::Base
  before_action :basic_auth  # メソッド呼び出し

  private # クラス外から呼び出すことができないメソッドを定義

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password| # Basic認証を実装するためのメソッド
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 任意のusernameとpassword指定
    end
  end
end
