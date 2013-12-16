class Profile < ActiveRecord::Base

  belongs_to :user

  has_one :contact_requirement
  has_many :experiences, dependent: :destroy
  has_many :portfolio_items, dependent: :destroy
  has_many :faqs
  has_many :educations, dependent: :destroy

  attr_accessible :user_id, :education, :experience, :skills, :skill1, :skill2, :skill3, :view_profile,
                  :experiences_attributes, :image, :portfolio_items_attributes,
                  :faqs_attributes, :hometown, :contact_requirement_attributes,
                  :educations_attributes

  accepts_nested_attributes_for :experiences, allow_destroy: true
  accepts_nested_attributes_for :portfolio_items, allow_destroy: true
  accepts_nested_attributes_for :faqs, allow_destroy: true
  accepts_nested_attributes_for :contact_requirement
  accepts_nested_attributes_for :educations

  mount_uploader :image, ImageUploader

  def display_skill
    arr = []
    arr << skill1 unless skill1.blank?
    arr << skill2 unless skill2.blank?
    arr << skill3 unless skill3.blank?
    return "" if arr.blank?
    str = "I am skilled at #{arr[0]}"
    str += " and #{arr[1]}" if arr.size==2
    str += ", #{arr[1]} and #{arr[2]}" if arr.size==3
    str
  end

  def build_from_linkedin(omniauth)
    token = omniauth['credentials']['token']
    secret = omniauth['credentials']['secret']
    client = LinkedIn::Client.new
    client.authorize_from_access(token, secret)
    in_profile = client.profile(id: omniauth['uid'], :fields => [:headline, :first_name, :last_name, :educations, :skills, :positions])
    
    in_educations = in_profile["educations"].all
    unless in_educations.blank?
      in_educations.each do |edu|
        self.educations.create(university: edu["school_name"], degree_type: edu["degree"], major: edu["field_of_study"], graduation_year: edu["end_date"]["year"] ) 
      end
    end

    in_experiences = in_profile["positions"].all
    unless in_experiences.blank?
      in_experiences.each do |exp|
        start_date = "#{exp['start_date']['month']}/01/#{exp['start_date']['year']}" if exp["start_date"]
        end_date = "#{exp['end_date']['month']}/01/#{exp['end_date']['year']}" if exp["end_date"]
        experiences.create(position_name: exp["title"], company_name: "#{exp['company']['name'] if exp['company']}",
          date_started: start_date,
          date_ended: end_date,
          present: exp["is_current"]
        )
      end
    end

    in_skills = in_profile["skills"].all.first(3)
    self.skill1 = in_skills[0]["skill"]["name"] unless in_skills[0].blank?
    self.skill2 = in_skills[1]["skill"]["name"] unless in_skills[1].blank?
    self.skill3 = in_skills[2]["skill"]["name"] unless in_skills[2].blank?

    self.save
    user.update_attribute(:major, educations.last.major) if educations.last
  end
end