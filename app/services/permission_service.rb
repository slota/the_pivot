class PermissionService
  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new(role: nil)
  end

  def allow?(controller, action)
    @controller = controller
    @action = action

    case
    when user.platform_admin?  then platform_admin_permissions
    when user.business_admin?  then business_admin_permissions
    when user.registered_user? then registered_user_permissions
    else                             guest_user_permissions
    end
  end

  def platform_admin_permissions
    true
  end

  def business_admin_permissions
    return true if controller == "pages" && action.in?(%w(home about))
    true
  end

  def registered_user_permissions
    return true if controller == "pages" && action.in?(%w(home about))
    return true if controller == "sessions"
    return true if controller == "users" && action.in?(%w(new create show))
    return true if controller == "venues" && action.in?(%w(show))
    return true if controller == "venues/concert" && action.in?(%w(show))
    return true if controller == "cart_concerts"
  end

  def guest_user_permissions
    return true if controller == "pages" && action.in?(%w(home about))
    return true if controller == "sessions"
    return true if controller == "users" && action.in?(%w(new create))
    return true if controller == "venues" && action.in?(%w(show))
    return true if controller == "venues/concert" && action.in?(%w(show))
    return true if controller == "orders" && action.in?(%w(new))
    return true if controller == "cart_concerts"
  end
end
