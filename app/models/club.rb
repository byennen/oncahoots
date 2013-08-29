class Club < ActiveRecord::Base
  belongs_to :university
  belongs_to :user

  attr_accessible :category, :description, :name, :university_id, :image, :remote_image_url, :user_id

  CLUB_TYPES = %w(Social Gender Media Performance Recreational Religious Service Student Govt. Team Sports Metropolitan)

  mount_uploader :image, ImageUploader
end
