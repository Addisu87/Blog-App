class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    can :create, :all

    # if the user is logged in can manage it's own posts and comments
    can :manage, Post, author_id: user.id
    can :magage, Comment, author_id: user.id
    can :destroy, :all if user.is? :admin
  end
end
