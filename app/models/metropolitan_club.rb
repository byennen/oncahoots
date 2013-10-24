class MetropolitanClub < Club
  belongs_to :city
  attr_accessible :city_id

  validate :city, uniquesness: {scope: :university_id}

  after_create :generate_name

  def members
    User.where(university_id: university_id, city_id: city_id)
  end

  private
    def generate_name
      update_attribute :name, "#{university.name} of #{city.name}"
    end
end