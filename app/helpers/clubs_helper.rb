module ClubsHelper

  def major(user)
    user.major.present? ? user.major : 'No Major'
  end
end
