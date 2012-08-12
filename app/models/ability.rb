class Ability
  include CanCan::Ability
  # 0:everybody, 1:guest, 4:padawan, 8:player, 12:moderator, 16:admin


  def default(user)
    puts "Rights: default"
    # can :read, :all # doesn't do that ! We will authorize each actions
    can :read, [Doc,Gallery, Image, Place]
    can :manage, User, :id => user.id
    cannot :destroy, User, :id => user.id

    can :read, ForumCategory, ["role <= ?", user.role] do |forum_category|
      forum_category.role <= user.role
    end
    can :read, Forum, ["role <= ?", user.role] do |forum|
      forum.role <= user.role
      can :read, Topic, Topic.where(:forum_id => forum.id) do |topic|
        can :read, Message, :topic_id => topic.id
      end
    end

    # special actions
    can :mark_all_read, Forum
  end

  def guest(user)
    puts "Rights: guest"
    can :create, [Topic, Message]
    can :edit, [Topic, Message], :user_id => user.id

    can :read, Pm, :to => user.id         # Can read if receptor
    can :manage, Pm, :user_id => user.id  # Can manage if emittor
    can :create, Pm                       # Otherwise, can create Pms
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
    can :manage, Doc, :modos_only => false
  end

  def moderator_admin(user)
    puts "Rights: moderator or admin"
    can :manage, [Place, Forum, Topic, Message, Gallery, Image, Doc, ForumCategory, User]
    can :read, Log
  end

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == nil
      user.role = 0
    end
    # roles :
    # 0:everybody, 1:guest, 4:padawan, 8:player, 12:moderator, 16:admin
    if !user.role or user.new_record?
      default(user)
    else
      default(user)
      guest(user) if user.role >= 1
      padawan(user) if user.role >= 4
      player(user) if user.role >= 8
      moderator_admin(user) if user.role >= 12 # will match 16(admin) too
    end
  end
end
