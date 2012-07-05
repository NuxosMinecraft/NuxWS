class Ability
  include CanCan::Ability

  def default(user)
    puts "Rights: default"
    can :read, :all
    can :manage, User, :id => user.id
    cannot :destroy, User, :id => user.id
  end
  
  def guest(user)
    puts "Rights: guest"
    can :create, Topic, Message
    can :edit, [Topic, Message], :user_id => user.id
  end
  
  def padawan(user)
    puts "Rights: padawan"
    cannot [:create, :edit, :destroy], Message, :topic => {:locked => true}
    cannot [:edit, :destroy], Topic, :locked => true
    cannot [:edit, :destroy], Message, :deleted => true 
  end
  
  def player(user)
    puts "Rights: player"
    can :manage, [Gallery, Image] # no specific user association
    can :manage, [Place, Topic, Message], :user_id => user.id
    cannot :destroy, [Place, Topic, Message], :user_id => user.id
    can :manage, [Doc], :modos_only => false
  end
  
  def moderator_admin(user)
    puts "Rights: moderator or admin"
    can :manage, [Place, Forum, Topic, Message, Gallery, Image, Doc, ForumCategory, User]
    can :read, Log
  end

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # roles :
    # 1:guest, 4:padawan, 8:player, 12:moderator, 16:admin
    if !user.role or user.new_record?
      default(user)
    else
      default(user)
      guest(user) if user.role.rid >= 1
      padawan(user) if user.role.rid >= 4
      player(user) if user.role.rid >= 8
      moderator_admin(user) if user.role.rid >= 12 # will match 16(admin) too
    end
  end
end
