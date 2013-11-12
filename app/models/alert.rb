class Alert < ActiveRecord::Base

  attr_accessible :alertable_id, :alertable_type, :message

  validates :alertable_id, :alertable_type, :message, presence: true

  belongs_to :alertable, polymorphic: true

  # TODO: Need to find a better way long term. - jkr
  def self.create_profile_update(user, params)
    Rails.logger.debug("params are #{params.inspect}")
    params.each do |key, value|
      k = key.gsub("_attributes", "")
      updated_attribute = k.split("_").join(" ").capitalize
      if @alert = self.create({alertable_id: user.id, alertable_type: 'User', message: "has updated their #{updated_attribute} profile"})
        user.contacts.each do |contact|
          AlertUserNotification.create({user_id: contact.id, alert_id: @alert.id})
        end
      end
    end
  end

  def self.create_relationship_notification(relationship)
    alert = self.create({alertable_id: relationship.relation_id, alertable_type: 'User', message: "has accepted your contact request"})
    AlertUserNotification.create({user_id: relationship.user_id, alert_id: alert.id})
  end

  def self.create_club_event_notification(club_event)
    alert = self.create({alertable_id: club_event.eventable_id, alertable_type: 'Club', message: "has added an event"})
    club_event.eventable.users.each do |user|
      AlertUserNotification.create({user_id: user.id, alert_id: alert.id})
    end
  end

  def self.create_club_membership_notification(club, membership)
    alert = self.create({alertable_id: club.id, alertable_type: 'Club', message: "#{membership.user.name} has joined the club"})
    club.memberships.each do |membership|
      AlertUserNotification.create({user_id: membership.user.id, alert_id: alert.id})
    end
  end

end
