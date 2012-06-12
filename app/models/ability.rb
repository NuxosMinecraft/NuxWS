class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # roles :
    # 1:guest, 4:padawan, 8:player, 12:moderator, 16:admin
    if !user.role or user.new_record?
      # Guest
      can :read, :all
      can :create, User
    else
      can :read, :all
      can :manage, User, :id => user.id
      cannot :destroy, User, :id => user.id
      
      if user.role.rid == 4 or user.role.rid == 8
        # padawan or player
        can :manage, [Gallery, Image] # no specific user association
        can :manage, [Place, Topic, Message], :user_id => user.id
        cannot :destroy, [Place, Topic, Message], :user_id => user.id
        can :manage, [Doc], :modos_only => false
        cannot [:create, :edit, :destroy], Message, :topic => {:locked => true}
        cannot [:edit, :destroy], Topic, :locked => true
        cannot [:edit, :destroy], Message, :deleted => true
        
      end
      if user.role.rid == 12
        # moderator
        can :manage, [Place, Forum, Topic, Message, Gallery, Image, Doc, ForumCategory, User]
      end
      if user.role.rid == 16
        # Admin
        can :manage, [Place, Forum, Topic, Message, Gallery, Image, Doc, ForumCategory, User]
      end
    end
  end
end
