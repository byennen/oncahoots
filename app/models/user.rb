class User < ActiveRecord::Base
  belongs_to :university
  belongs_to :location
  belongs_to :professional_field
  belongs_to :city

  has_one :profile

  has_many :memberships
  has_many :clubs, :through => :memberships
  has_many :relationships
  has_many :relations, through: :relationships
  has_many :contacts, :through => :relationships, :source => :relation, :conditions => {"relationships.status" => "accepted"}

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me,
                  :university_id, :location_id, :graduation_year, :major, :double_major, :slug,
                  :city_id, :state, :alumni, :professional_field_id, :role_ids, :university_id, :graduation_year

  validates_presence_of :university_id, :graduation_year, :major

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
  #scope :by_name, -> (query) { where('((users.first_name || ' ' || users.last_name) ILIKE ?) OR (users.first_name ILIKE ?) OR (users.last_name ILIKE ?)', "%#{query}%", "%#{query}%", "%#{query}%") }
  #scope :by_email, -> (query) { where("email ILIKE ?", "%{query}%") }
  scope :by_name_and_email, ->(query) { by_name(query).by_email(query) }

  extend FriendlyId
  friendly_id :username_for_friendlyid, :use => :slugged


  acts_as_messageable

  def self.search(query, filters={})
    cscope = scoped({})
    # Add filte scopes.
    filters.each do |key, value|
      cscope.merge(User.send(key, value)) if !value.nil?
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

  def display_city
    city ? city.name : "Other"
  end

  def display_location
    location ? location.name : city.name
  end

  def display_major
    "#{major}#{' and ' unless double_major.blank?}#{double_major}"
  end

  def metropolitan_club
    return if city_id.blank? || university_id.blank?
    MetropolitanClub.where(city_id: city_id, university_id: university_id).first
  end

  def username_for_friendlyid
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

  def join_club?(club)
    clubs.include?(club)
  end

  class << self 
    def search_all(params)
      return where("1=1") if params.blank?
      search_name(params[:name]).search_location(params[:loc]).search_type(params[:type])
      .search_major(params[:major]).search_graduation_year(params[:year]).search_professional_field(params[:field]).search_city(params[:city])
    end
    def search_name(name)
      return where("1=1") if name.blank?
      where("lower(first_name) like ? or lower(last_name) like ?", "%#{name.downcase}%", "%#{name.downcase}%")
    end

    def search_city(city_name)
      return where("1=1") if city_name.blank? || city_name == "All cities"
      city = City.find_by_name(city_name)
      return where("1=2") unless city
      where(city_id: city.id)
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

    def search_graduation_year(year)
      return where("1=1") if year.blank? || year=="Any Year"
      where(graduation_year: year)
    end

    def search_professional_field(field_name)
      return where("1=1") if field_name.blank? || field_name=="All Fields"
      field = ProfessionalField.find_by_name(field_name)
      return where("1=2") unless field
      where(professional_field_id: field.id)
    end

  end
end
