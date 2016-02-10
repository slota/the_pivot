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
    return true if controller == "sessions"
    return true if controller == "users" && action.in?(%w(new create show edit update))
    return true if controller == "venues" && action.in?(%w(show index new create edit update))
    return true if controller == "venues/concert" && action.in?(%w(show new create destroy))
    return true if controller == "orders" && action.in?(%w(new create index show))
    return true if controller == "cart_concerts"
    return true if controller == "concerts" && action.in?(%w(edit update))
    return true if controller == "venues/managers" && action.in?(%w(create destroy))
  end

  def registered_user_permissions
    return true if controller == "pages" && action.in?(%w(home about))
    return true if controller == "sessions"
    return true if controller == "users" && action.in?(%w(new create show edit update))
    return true if controller == "venues" && action.in?(%w(show))
    return true if controller == "venues/concert" && action.in?(%w(show))
    return true if controller == "orders" && action.in?(%w(new create index show))
    return true if controller == "cart_concerts"
    return true if controller == "notification"
  end

  def guest_user_permissions
    return true if controller == "pages" && action.in?(%w(home about))
    return true if controller == "sessions"
    return true if controller == "users" && action.in?(%w(new create))
    return true if controller == "venues" && action.in?(%w(show))
    return true if controller == "venues/concert" && action.in?(%w(show))
    return true if controller == "cart_concerts"
  end
end
