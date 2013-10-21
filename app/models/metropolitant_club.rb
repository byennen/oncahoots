class MetropolitantClub < Club
  belongs_to :city
  attr_accessible :city_id

  validate :city, uniquesness: {scope: :university_id}

  after_create :generate_name
  private
    def generate_name
      update_attribute :name, "#{university.name} of #{city.name}"
    end
end