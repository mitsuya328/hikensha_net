class ApplicationController < ActionController::Base
  include SessionsHelper
  add_flash_types :success, :info, :warning, :danger

  private
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        #flash[:danger] = "ログインしてください"
        redirect_to login_url, danger: "ログインしてください"
      end
    end
end
