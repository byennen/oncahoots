class Relationship < ActiveRecord::Base

  VALID_STATES = %w(pending requested accepted declined deleted recommended).freeze

  attr_accessible :user_id, :relation_id, :status, :message, :recommended_by_id

  belongs_to :user
  belongs_to :relation, class_name: 'User', foreign_key: 'relation_id'
  belongs_to :recommended_by, class_name: 'User', foreign_key: 'recommended_by_id'

  default_scope where("status <> 'deleted'")

  scope :by_user, ->(user) { where(user_id: user.id) }
  scope :by_relationship, ->(relation) { where(user_id: relation.id) }
  scope :accepted, where("status = ?", "accepted")

  def self.exists?(user, relation)
     relationship = find_by_user_id_and_relation_id(user.id, relation.id)
     relationship.nil? ? false : true
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

  def self.accepted?(user, relation)
    relationship = find_relationship(user, relation)
    (relationship && relationship.accepted?) ? true : false
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
    unless user == relation || Relationship.reciprocal?(user, relation)
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
    inverse.update_attribute(:status, "deleted") if inverse
  end

  def recommend!(refer_user)
    inverse = find_inverse
    message = "#{user.name} has recommended you to #{refer_user.name}.  Do you wish to proceed?"
    unless user == refer_user || Relationship.exists?(relation, refer_user) 
      relationship = Relationship.create!(user_id: relation_id, relation_id: refer_user.id, status: 'recommended', recommended_by_id: user.id, message: message)
    end
    return relationship
  end

  def accept_recommendation!
    self.remove!
    Relationship.request(user, relation, "#{recommended_by.name} has recommended you to #{user.name}") if recommended_by.present?
  end

  def decline_recommendation!
    update_attribute(:status, "deleted")
  end

  private

  def find_inverse
    return Relationship.find_by_user_id_and_relation_id(self.relation_id, self.user_id)
  end

end
