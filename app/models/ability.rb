class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    end
    if user.new_record?
      can :read, :all
      can :create, User
    else
      can :read, :all
      # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

      can :manage, User, :id => user.id

      #can :create, Place
      #can :create, Doc

      #can :manage, Place, :user_id => user.id
      #can :manage, Doc, :user_id => user.id
    end
  end
end
