class MetropolitanClub < Club
  belongs_to :city
  attr_accessible :city_id, :university_id

  def members
    User.where(university_id: university_id, city_id: city_id)
  end

end