class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all

    return unless user.present?

    # if the user is logged in can manage it's own posts and comments
    can :manage, Post, author_id: user.id
    can :magage, Comment
  end
end
