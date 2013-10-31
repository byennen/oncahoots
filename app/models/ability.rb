class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    club_ids = user.university.clubs.map(&:id)
    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :university_admin
      can :manage, User, university_id: user.university_id
      can :manage, Update
    else
      can [:read, :create], Update, updateable_id: user.metropolitan_club.id, updateable_type: "Club"
      can [:update, :destroy], Update, user_id: user.id
    end
  end
end
