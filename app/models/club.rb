class Club < ActiveRecord::Base
  belongs_to :university

  has_many :memberships

  has_many :users, :through => :memberships, :uniq => true
  has_many :club_photos
  has_many :events
  has_many :statuses # this is lowdowns here
  has_many :records
  has_many :updates, as: :updateable
  has_many :leaders, through: :memberships, source: :user, conditions: {"memberships.admin" => true}
  has_many :posts
  
  attr_accessible :category, :description, :name, :university_id, :image,
                  :remote_image_url, :user_id, :slug, :private, :mission_statement

  validates :name, presence: true
  validates :university_id, presence: true

  CATEGORIES = [
    "Academic",
    "Alumni",
    "Arts",
    "Social",
    "Gender",
    "Health",
    "Media",
    "Performance",
    "Political",
    "Recreational",
    "Sports",
    "Religious",
    "Service",
    "Student Govt",
    "Union Board"
  ]
  mount_uploader :image, ImageUploader

  acts_as_messageable
  
  extend FriendlyId
  friendly_id :name, use: :slugged


  def admins
    @admins ||= memberships.where(admin: true).all.map(&:user)
  end

  class << self
    def search_all(params)
      search_name(params[:name]).search_category(params[:category])
    end
    def search_name(name)
      return where("1=1") if name.blank?
      where("lower(name) like ?", "%#{name.downcase}%")
    end

    def search_category(category)
      return where("1=1") if(category.blank? || category == "All categories")
      where("category=?", category)
    end
  end
end
