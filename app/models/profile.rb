class Profile < ActiveRecord::Base

  belongs_to :user

  has_one :contact_requirement
  has_many :experiences
  has_many :portfolio_items
  has_many :faqs

  attr_accessible :user_id, :education, :experience, :skills, :view_profile,
                  :experiences_attributes, :image, :portfolio_items_attributes,
                  :faqs_attributes, :hometown

  accepts_nested_attributes_for :experiences, allow_destroy: true
  accepts_nested_attributes_for :portfolio_items, allow_destroy: true
  accepts_nested_attributes_for :faqs, allow_destroy: true

  mount_uploader :image, ImageUploader

end
