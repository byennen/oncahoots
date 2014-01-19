class Post < ActiveRecord::Base
  belongs_to :club
  belongs_to :user
  attr_accessible :content, :title, :club_id

  has_many :comments, as: :commentable, dependent: :destroy

  validates :content, presence: true
end
