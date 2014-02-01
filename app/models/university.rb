class University < ActiveRecord::Base
  has_many :users
  has_many :updates, as: :updateable

  has_many :clubs, dependent: :destroy
  has_many :metropolitan_clubs, dependent: :destroy
  has_many :events

  attr_accessible :location, :mascot, :name, :image, :banner, :slug

  mount_uploader :image, ImageUploader
  mount_uploader :banner, BannerUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  after_create :create_metropolitan_clubs

  def metropolitan_club(city_id)
    metropolitan_clubs.find_by_city_id city_id
  end

  def most_popular_club
    unless @most_popular_club.present?
      club_ids = clubs.pluck(:id)
      most_popular_club_grouped_membership = Membership.select("count(*) as membership_count, club_id").group(:club_id).where("club_id in (?)", club_ids).order("membership_count desc").limit(1).first
      @most_popular_club = most_popular_club_grouped_membership.present? ? most_popular_club_grouped_membership.club : Club.find_by_id(club_ids[rand(club_ids.length)])
    end
    @most_popular_club
  end

  private
    def create_metropolitan_clubs
      City.all.each do |city|
        metropolitan_clubs.create(city_id: city.id)
      end
    end
end
