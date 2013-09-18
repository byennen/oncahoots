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

  mount_uploader :image, ImageUploader

  extend FriendlyId
  friendly_id :name, use: :slugged


  def admins
    @admins ||= memberships.where(admin: true).all.map(&:user)
  end

end
