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

  after_create :create_user_profile

  # Scopes
  scope :alumni, where(alumni: true)
  scope :student, where("alumni is null or alumni=false")

  # Search scopes
  scope :by_alumni_student, ->(alumni) { where(alumni: alumni) }
  scope :by_location, ->(location) { where(location_id: location) }
  scope :by_graduation_year, ->(grad_year) { where(graduation_year: grad_year) }
  scope :by_professional_field, ->(field) { where(professional_field_id: field) }
  scope :by_major, ->(major) { where("major like ?", "%#{major}%") }
  scope :by_name, -> (query) { where('((users.first_name || ' ' || users.last_name) ILIKE ?) OR (users.first_name ILIKE ?) OR (users.last_name ILIKE ?)', "%#{query}%", "%#{query}%", "%#{query}%") }
  scope :by_email, -> (query) { where("email ILIKE ?", "%{query}%") }
  scope :by_name_and_email, ->(query) { by_name(query).by_email(query) } 

  extend FriendlyId
  friendly_id :username, :use => :slugged


  acts_as_messageable

  def self.search(query, filters={})
    cscope = scoped({})
    # Add filte scopes.
    filters.each do |key, value|
      cscope.merge(User.send(key, value))
    end
    cscope.merge(User.send(:by_name_and_email, query)) unless query.nil?
    return cscope.all
  end

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
      return where(true) if name.blank?
      where("lower(name) like ?", "%#{name}%")
    end

    def search_location(location_id)
      return where(true) if location_id.blank?
      where(location_id: location_id)
    end

    def search_type(utype)
      return where(true) if utype.blank? || utype == "Both"
      utype=="Alumni" ? alumni : student
    end

    def search_major(major)
      return where(true) if major.blank?
      where(major: major)
    end

    def search_graduaration_year(year)
      return where(true) if year.blank?
      where(graduation_year: year)
    end
  end
end
