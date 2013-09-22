module ProfilesHelper

  def experience_string(experience)
    experience_string = "#{experience.date_started.strftime("%m-%Y")} - "
    if experience.present
      experience_string += "Present"
    else
      experience_string += experience.date_ended.strftime("%m-%Y")
    end
    return experience_string
  end
end
