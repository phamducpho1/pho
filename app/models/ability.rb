class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :create, :suggest
      can :update, current_user
      can [:destroy,:create], :cart
    end
  end
end
