class Profile < ActiveRecord::Base

  belongs_to :user

  has_one :contact_requirement
  has_many :experiences, dependent: :destroy
  has_many :portfolio_items, dependent: :destroy
  has_many :faqs
  has_one :education, dependent: :destroy

  attr_accessible :user_id, :education, :experience, :skills, :skill1, :skill2, :skill3, :view_profile,
                  :experiences_attributes, :image, :portfolio_items_attributes,
                  :faqs_attributes, :hometown, :contact_requirement_attributes,
                  :education_attributes

  accepts_nested_attributes_for :experiences, allow_destroy: true
  accepts_nested_attributes_for :portfolio_items, allow_destroy: true
  accepts_nested_attributes_for :faqs, allow_destroy: true
  accepts_nested_attributes_for :contact_requirement
  accepts_nested_attributes_for :education

  mount_uploader :image, ImageUploader

  def build_from_linkedin(omniauth)
    token = omniauth['credentials']['token']
    secret = omniauth['credentials']['secret']
    client = LinkedIn::Client.new
    client.authorize_from_access(token, secret)
    in_profile = client.profile(id: omniauth['uid'], :fields => [:headline, :first_name, :last_name, :educations, :skills, :positions])
    
    in_edu = in_profile["educations"].all.first
    self.create_education(university: in_edu["school_name"], degree_type: in_edu["degree"], major: in_edu["field_of_study"], graduation_year: in_edu["end_date"]["year"] ) 
      
    in_experiences = in_profile["positions"].all
    in_experiences.each do |exp|
      start_date = "#{exp['start_date']['month']}/01/#{exp['start_date']['year']}" if exp["start_date"]
      end_date = "#{exp['end_date']['month']}/01/#{exp['end_date']['year']}" if exp["end_date"]
      experiences.create(position_name: exp["title"], company_name: "#{exp['company']['name'] if exp['company']}",
        date_started: start_date,
        date_ended: end_date,
        present: exp["is_current"]
      )
    end

    in_skills = in_profile["skills"].all.first(3)
    self.skill1 = in_skills[0]["skill"]["name"] unless in_skills[0].blank?
    self.skill2 = in_skills[1]["skill"]["name"] unless in_skills[1].blank?
    self.skill3 = in_skills[2]["skill"]["name"] unless in_skills[2].blank?

    self.save
    user.update_attribute :major, in_edu["field_of_study"]
  end
end
