class Club < ActiveRecord::Base
  belongs_to :university

  has_many :memberships
  has_many :users, :through => :memberships, :uniq => true
  has_many :albums
  has_many :club_photos, through: :albums
  has_many :events
  has_many :statuses # this is lowdowns here
  has_many :records
  has_many :updates, as: :updateable
  has_many :leaders, through: :memberships, source: :user, conditions: {"memberships.admin" => true}
  has_many :posts
  has_many :items
  has_many :customers
  has_many :transactions

  has_one :stripe_credential, as: :owner
  belongs_to :user

  attr_accessible :category, :description, :name, :university_id, :image,
                  :remote_image_url, :user_id, :slug, :private, :mission_statement

  validates :name, presence: true
  validates :university_id, presence: true
  validates :user_id, presence: true
  validates :image, presence: true, on: :create
  
  scope :sup_club, where(type: nil)
  scope :privates, where(:private => true)
  scope :publics, where("clubs.private is null or clubs.private=false")
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

  def members
    users
  end

  def non_leaders
    ids = users.with_role(:super_admin).map(&:id).to_a + users.with_role(:university_admin).map(&:id).to_a
    mems = users
    mems = users.where("users.id not in (?)", ids) unless ids.blank?
    return mems if leaders.blank?
    mems.where("users.id not in (?)", leaders.map(&:id))
  end

  class << self
    def search_all(params)
      search_name(params[:name]).search_category(params[:category]).search_private(params[:private])
    end
    def search_name(name)
      return where("1=1") if name.blank?
      where("lower(name) like ?", "%#{name.downcase}%")
    end

    def search_category(category)
      return where("1=1") if(category.blank? || category == "All categories")
      where("category=?", category)
    end

    def search_private(priv)
      return where("1=1") if priv.blank?
      priv=="true" ? privates : publics    
    end

  end
end
