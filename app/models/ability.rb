class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :university_admin
      can :manage, User, university_id: user.university_id
      can :manage, Update
    elsif user.metropolitan_club_admin? 
      can :manage, Update do |update|
        update.updateable == user.metropolitan_club
      end
      can :create, Update, updateable_id: user.metropolitan_club.id
    else
      can :show, Update
    end
    can :show, Update
  end
end
