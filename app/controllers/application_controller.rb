class ApplicationController < ActionController::Base
  include Pundit::Authorization

  def after_sign_in_path_for(resource)
    if current_user.line_id.blank?
      flash[:warning] = "初期設定が完了していません。サイドバーの導入手順をご確認ください"
    end

    sites_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
