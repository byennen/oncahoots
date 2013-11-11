class Invitation < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  belongs_to :club

  validates_presence_of :recipient_id

  attr_accessible :new, :recipient_id, :sender_id, :sent_at, :token, :club_id

  before_create :generate_token
  after_create :send_message

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  private
    def send_message
      path = "/clubs/#{club.slug || club.id}/join?token=#{token}"
      content = "#{sender.name} invites you to join the club #{club.name}."
      content += " <a href='#{path}' class='btn btn-success btn-mini'>join</a>"
      sender.send_message(recipient, content.html_safe, "Invitation to Club", true)
    end
end
