class Update < ActiveRecord::Base
  attr_accessible :headline, :body, :image, :user_id
  
  belongs_to :updateable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable

  mount_uploader :image, ImageUploader

  validates_presence_of :body
  validates_presence_of :headline

  default_scope order("created_at desc")
  def as_json options={}
		super(
			only: [:id, :headline, :body, :image, :created_at],
			include: { 
				comments: {
					only: [:id, :comment, :created_at],
					include: {
						user: { 
							only: [:id, :first_name, :last_name],
							include: { profile: {only: [:id, :image]}}
						}
					}
				}
			}
		)
	end

end
