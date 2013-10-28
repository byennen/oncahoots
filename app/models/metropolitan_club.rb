class MetropolitanClub < Club
	attr_accessible :city_id, :university_id
	
  belongs_to :city

  def members
    User.where(university_id: university_id, city_id: city_id)
  end
end