class User < ActiveRecord::Base
  belongs_to :university
  belongs_to :location
  belongs_to :professional_field

  has_one :profile

  has_many :memberships
  has_many :clubs, :through => :memberships

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me,
                  :university_id, :location_id, :graduation_year, :major, :double_major, :slug,
                  :city, :state, :alumni, :professional_field_id

  validates_presence_of :university_id, :graduation_year, :major, :city, :state

  after_create :create_user_profile

  extend FriendlyId
  friendly_id :username, :use => :slugged

  acts_as_messageable

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
end
