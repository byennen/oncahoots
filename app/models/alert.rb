class Alert < ActiveRecord::Base

  attr_accessible :alertable_id, :alertable_type, :message

  validates :alertable_id, :alertable_type, :message, presence: true

  belongs_to :alertable, polymorphic: true

  # TODO: Need to find a better way long term. - jkr
  def self.create_profile_update(user, params)
    skills = []
    message = "has updated "
    params.each do |key, value|
      if %w(skill1 skill2 skill3).include?(key)
        skills << value unless value.blank?
        message += "skills to include #{skills.join(", ")}"
      else
        k = key.gsub("_attributes", "")
        updated_attribute = k.split("_").join(" ").capitalize
        message += "#{updated_attribute} profile:"
        hash = {}
        value.each do |count, obj|
          text = []
          obj.except('id', '_destroy').each do |att, attr_val|
            text << "<strong>#{att.gsub("_"," ").capitalize}:</strong> #{attr_val}"
          end
          if obj["_destroy"] == 'false'
            message += "<p>#{text.join(", ")}</p>".html_safe
          else
            message += "<p class='red'> Delete #{text.join(", ")}</p>".html_safe
          end
        end
      end
    end

    if alert = self.create({alertable_id: user.id, alertable_type: 'User', message: message.html_safe})
      user.contacts.each do |contact|
        AlertUserNotification.create({user_id: contact.id, alert_id: alert.id})
      end
    end
  end

  def self.create_user_update(user, params)
    text = []
    params.except('id', 'city_id', 'other_city', 'university_id').each do |att, attr_val|
      text << "<strong>#{att.gsub("_"," ").capitalize}:</strong> #{attr_val}"
    end
    unless params[:university_id].blank?
      text << "<strong>University:</strong> #{University.find(params['university_id']).name}"
    end
    if params[:city_id].blank? || params[:city_id]=='0'
      text << "<strong>City:</strong> #{params['other_city']}"
    else
      text << "<strong>City:</strong> #{City.find(params['city_id']).name}"
    end
    message = "has updated basic info<p>#{text.join(", ")}</p>".html_safe
  
    if alert = self.create({alertable_id: user.id, alertable_type: 'User', message: message.html_safe})
      user.contacts.each do |contact|
        AlertUserNotification.create({user_id: contact.id, alert_id: alert.id})
      end
    end
  end

  def self.create_relationship_notification(relationship)
    alert = self.create({alertable_id: relationship.user_id, alertable_type: 'User', message: "has accepted your contact request"})
    AlertUserNotification.create({user_id: relationship.relation_id, alert_id: alert.id})
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
