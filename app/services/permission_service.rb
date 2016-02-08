class PermissionService
  # extend Forwardable

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action

    case
    when @user.platform_admin?  then platform_admin_permissions
    when @user.business_admin?  then business_admin_permissions
    when @user.registered_user? then registered_user_permissions
    else                             guest_permissions
    end
    true
  end

  def platform_admin_permissions
    true
  end

  def business_admin_permissions
    return true if controller == "items" && action.in?(%w(index show))
    true
  end

  def registered_user_permissions
    true
  end

  def guest_user_permissions
    return true if controller == "items" && action.in?(%w(index show))
    true
  end
end
