class Comment < ActiveRecord::Base
  attr_accessible :comment, :user_id

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates_presence_of :comment

  def as_json options={}
		super(
			only: [:id, :comment, :created_at],
			include: {
				user: { 
					only: [:id, :first_name, :last_name],
					include: { profile: {only: [:id, :image]}}
				}
			}
		)
	end
end
