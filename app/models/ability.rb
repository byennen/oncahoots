class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :university_admin
      can :manage, User, university_id: user.university_id
      #can :manage, Club, university_id: user.university_id
    #elsif user.has_role? :member
    #  #can
    end
  end
end
