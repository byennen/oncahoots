class MetropolitanClub < Club
	attr_accessible :city_id, :university_id
	
  belongs_to :city

  attr_accessible :city_id, :university_id

  before_save :default_category

  def members
    User.where(university_id: university_id, city_id: city_id)
  end

  def non_leaders
    mems = members.where("id not in (?)", members.with_role(:super_admin).map(&:id).to_a + members.with_role(:university_admin).map(&:id).to_a)
    return mems if leaders.blank?
    mems.where("id not in (?)", leaders.map(&:id))
  end

  def city_name
    (city && city.name) || name
  end

  def default_category
    self.category = 'Alumni' unless category.present?
    true
  end

end