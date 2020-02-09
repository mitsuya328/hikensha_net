class ApplicationController < ActionController::Base
  include SessionsHelper
  add_flash_types :success, :info, :warning, :danger

  before_action :set_search
  def set_search
    @q = Experiment.ransack(params[:q])
  end

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
