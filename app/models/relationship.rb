class Relationship < ActiveRecord::Base

  VALID_STATES = %w(pending requested accepted declined deleted recommended).freeze

  attr_accessible :user_id, :relation_id, :status, :message

  belongs_to :user
  belongs_to :relation, class_name: 'User', foreign_key: 'relation_id'

  scope :by_user, ->(user) { where(user_id: user.id) }
  scope :by_relationship, ->(relation) { where(user_id: relation.id) }
  scope :accepted, where("status = ?", "accepted") 

  def self.exists?(user, relation)
     relationships = find_by_user_id_and_relation_id(user.id, relation.id)
     relationships.nil? ? false : true
  end

  def self.reciprocal?(user, relation)
    relationship = find_by_user_id_and_relation_id(user.id, relation.id)
    (relationship && relationship.accepted?) ? true : false
  end

  def self.requested?(user, relation)
    relationship = find_relationship(user, relation)
    (relationship && relationship.requested?) ? true : false
  end

  def self.pending?(user, relation)
    relationship = find_relationship(user, relation)
    (relationship && relationship.pending?) ? true : false
  end

  def self.declined?(user, relation)
    relationship = find_relationship(user, relation)
    (relationship && relationship.declined?) ? true : false
  end

  def self.pending?(user, relation)
    relationship = find_relationship(user, relation)
    (relationship && relationship.pending?) ? true : false
  end

  def self.recommended?(user, relation)
    relationship = find_relationship(user,relation)
    (relationship && relationship.recommended?) ? true : false
  end

  def self.request(user, relation, message='')
    unless user == relation || Relationship.exists?(user, relation)
      create(user_id: user.id, relation_id: relation.id, status: 'requested', message: message)
      create(user_id: relation.id, relation_id: user.id, status: 'pending', message: message)
    end
  end

  def self.find_relationship(user, relation)
    return find_by_user_id_and_relation_id(user.id, relation.id)
  end

  # States
  VALID_STATES.each do |state|

    define_method("#{state}?") do
      status == state
    end

  end

  def accept!
    inverse = find_inverse
    self.update_attribute(:status, 'accepted')
    inverse.update_attribute(:status, 'accepted')
  end

  def decline!
    inverse = find_inverse
    self.update_attribute(:status, 'declined')
    inverse.update_attribute(:status, 'declined')
  end

  def remove!
    inverse = find_inverse
    self.update_attribute(:status, "deleted")
    inverse.update_attribute(:status, "deleted")
  end

  def recommend!(new_user)
    inverse = find_inverse
    message = "#{user.full_name} has recommended you to #{new_user.full_name}.  Do you wish to proceed?"
    unless user == relation || Relationship.exists?(user, new_user) 
      Relationship.create(user_id: relation_id, relation_id: new_user.id, status: 'recommended', message: message)
      new_relationship = Relationship.create(user_id: new_user.id, relation_id: relation_id, status: 'recommended', message: message)
    end
    return new_relationship
  end

  private

  def find_inverse
    return Relationship.find_by_user_id_and_relation_id(self.relation_id, self.user_id)
  end

end
