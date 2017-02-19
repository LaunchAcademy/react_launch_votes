class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?
  protect_from_forgery with: :exception

  def authenticate_admin!
    authenticate_user!
    if user_signed_in? && !current_user.admin?
      flash[:alert] = "You are not authorized to access this content."
      redirect_to root_path
    end
  end

  def authenticate_user!
    if !user_signed_in?
      persist_location!
      flash[:alert] = "You need to sign in before continuing."
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def persist_location!
    session[:post_auth_path] = request.path
  end

  def post_auth_path
    if session[:post_auth_path].present?
      post_auth_path = session[:post_auth_path]
      session.delete(:post_auth_path)
      return post_auth_path
    else
      return root_path
    end
  end

  def prevent_duplicate_sign_in
    if user_signed_in?
      flash[:alert] = "You are already signed in."
      redirect_to root_path
    end
  end

  def sign_in(user)
    user.increment! :sign_in_count
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end

  def user_signed_in?
    !current_user.nil?
  end
end
