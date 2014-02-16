class MetropolitanClub < Club
	attr_accessible :city_id, :university_id
	
  belongs_to :city

  attr_accessible :city_id, :university_id

  before_create :default_category

  class << self
    def metropolitan_clubs_sorted_by_popularity
      Rails.cache.fetch 'metropolitan_clubs_sorted_by_popularity', expires_in: 1.day do
        metropolitan_clubs_with_membership = Membership.memberships_sorted_by_popularity.where("clubs.type = 'MetropolitanClub'").limit(200).to_a.map(&:club_id).map { |club_id| Club.find_by_id(club_id) }
        other_metropolitan_clubs = MetropolitanClub.includes(:memberships).where(memberships: {club_id: nil}).limit(200).to_a
        (metropolitan_clubs_with_membership + other_metropolitan_clubs).compact
      end
    end
  end

  def members
    User.where(university_id: university_id, city_id: city_id)
  end

  def non_leaders
    mems = members.where("id not in (?)", members.with_role(:super_admin).map(&:id).to_a + members.with_role(:university_admin).map(&:id).to_a)
    return mems if leaders.blank?
    mems.where("id not in (?)", leaders.map(&:id))
  end

  def city_name
    # using splitter for orders of magnitude faster performance
    name.split(' ').to_a.last || (city && city.name) || name
  end

  def default_category
    self.category = 'Alumni' unless category.present?
    true
  end

end