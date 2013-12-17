module ProfilesHelper

  def experience_string(experience)
    experience_string = ""
    experience_string = "#{experience.date_started.strftime("%m-%Y")} - " unless experience.date_started.blank?
    if experience.present
      experience_string += "Present"
    else
      experience_string += experience.date_ended.strftime("%m-%Y") unless experience.date_ended.blank?
    end
    return experience_string
  end

  def can_view?(current_user, user)
     current_user == @user || Relationship.reciprocal?(current_user, user) || Relationship.requested?(current_user, user)
  end

end

