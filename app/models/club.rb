class Club < ActiveRecord::Base
  belongs_to :university

  has_many :memberships

  has_many :users
  has_many :users, :through => :memberships, :uniq => true
  has_many :club_photos
  has_many :club_events
  has_many :statuses # this is lowdowns here
  has_many :records
  has_many :updates, as: :updateable

  attr_accessible :category, :description, :name, :university_id, :image, 
                  :remote_image_url, :user_id, :slug, :private, :mission_statement

  CLUB_TYPES = %w(Social Gender Media Performance Recreational Religious Service Student Govt. Team Sports Metropolitan)
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
      return where(true) if name.blank?
      where("lower(name) like ?", "%#{name}%")
    end

    def search_category(category)
      return where(true) if(category.blank? || category == "All categories")
      where("category=?", category)
    end
  end
end
