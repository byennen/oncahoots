class User < ActiveRecord::Base
  belongs_to :university
  belongs_to :location
  belongs_to :professional_field

  has_one :profile

  has_many :memberships
  has_many :clubs, :through => :memberships
  has_many :relationships
  has_many :relations, through: :relationships

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me,
                  :university_id, :location_id, :graduation_year, :major, :double_major, :slug,
                  :city, :state, :alumni, :professional_field_id, :role_ids

  validates_presence_of :university_id, :graduation_year, :major, :city, :state

  scope :alumni, where(alumni: true)
  scope :student, where("alumni is null or alumni=false")

  after_create :create_user_profile

  extend FriendlyId
  friendly_id :username, :use => :slugged

  acts_as_messageable

  def relatable?(user)
    if self.university_id != user.university_id || self == user || Relationship.exists?(self, user)
      return false
    else
      return true
    end
  end

  def display_location
    location ? location.name : city
  end

  def username
    "#{first_name}-#{last_name}"
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def super_admin?
    has_role?(:super_admin)
  end

  def university_admin?
    has_role?(:university_admin)
  end

  def create_user_profile
    Profile.create(user_id: self.id)
  end

  class << self 
    def search_all(params)
      search_name(params[:name]).search_location(params[:loc]).search_type(params[:type])
      .search_major(params[:major]).search_graduaration_year(params[:year])
    end
    def search_name(name)
      return where("1=1") if name.blank?
      where("lower(first_name) like ? or lower(last_name) like ?", "%#{name.downcase}%", "%#{name.downcase}%")
    end

    def search_location(location)
      return where("1=1") if location.blank? || location == "All locations"
      loc = Location.find_by_name(location)
      return where("1=2") unless loc
      where(location_id: loc.id)
    end

    def search_type(utype)
      return where("1=1") if utype.blank? || utype == "Both"
      utype=="Alumni" ? alumni : student
    end

    def search_major(major)
      return where("1=1") if major.blank?
      where(major: major)
    end

    def search_graduaration_year(year)
      return where("1=1") if year.blank?
      where(graduation_year: year)
    end
  end
end
