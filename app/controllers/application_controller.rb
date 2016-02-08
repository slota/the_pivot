# require_relative
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_cart, :authorize!
  helper_method :oils,
                :current_user,
                :business_admin?,
                :platform_admin?,
                :return_oil_names

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def oils
    Oil.all
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def require_current_user
    render file: "/public/404" unless current_user
  end

  def platform_admin?
    current_user && current_user.role == "platform_admin"
  end

  def business_admin?
    current_user && current_user.role == "business_admin"
  end

  def authorize!
    unless authorized?
      # redirect_to root_url, danger: "Yes, and you are not allowed access ;)"
    end
  end

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end
end
