class MetropolitanClub < Club
	attr_accessible :city_id, :university_id
	
  belongs_to :city

  attr_accessible :city_id, :university_id

  class << self
    def metropolitan_clubs_sorted_by_popularity
      unless @metropolitan_clubs_sorted_by_popularity
        @metropolitan_clubs_sorted_by_popularity = Membership.memberships_sorted_by_popularity.where("clubs.type = 'MetropolitanClub'").limit(200).to_a.map(&:club_id).map {|club_id| Club.find_by_id(club_id)}.compact
      end
      @metropolitan_clubs_sorted_by_popularity
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

end