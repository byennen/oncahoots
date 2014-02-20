class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :club

  attr_accessible :admin, :manager, :club_id, :user_id, :title, :invitation_token

  #validates_presence_of :invitation_id, :message => 'is required'
  #validates_uniqueness_of :invitation_id

  scope :ordered, joins(:user).includes(:user).order("users.last_name, users.first_name")
  scope :alumni, ordered.where(users: {alumni: true})
  scope :student, ordered.where("users.alumni is null or users.alumni=false")
  scope :admin, ordered.where(admin: true)

  class << self
    def membership_counts_sorted_by_popularity
      Membership.select("count(*) as membership_count, club_id, clubs.type as club_type").group("club_id, clubs.type").joins("inner join clubs on club_id = clubs.id").order("membership_count desc")
    end
  end

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

  def message_leader(club_path)
    content = "You have been assigned to be a leader of <a href='#{club_path}'>#{club.name}</a> club.".html_safe
    club.send_message(user, content, "admin assignment notice", true)
  end
end
