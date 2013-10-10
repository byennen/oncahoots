class Relationship < ActiveRecord::Base

  attr_accessible :user_id, :relation_id, :status, :message

  belongs_to :user
  belongs_to :relation, class_name: 'User', foreign_key: 'relation_id'

  scope :by_user, ->(user) { where(user_id: user.id) }
  scope :by_relationship, ->(relation) { where(user_id: relation.id) }

  def self.exists?(user, relation)
     relationships = find_by_user_id_and_relation_id(user.id, relation.id)
     if relationships.nil?
       return false
     else
       return true
     end
  end

  def self.request(user, relation, message='')
    unless user == relation || Relationship.exists?(user, relation)
      create(user_id: user.id, relation_id: relation.id, status: 'requested', message: message)
      create(user_id: relation.id, relation_id: user.id, status: 'pending', message: message)
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


  private

  def find_inverse
    return Relationship.find_by_user_id_and_relation_id(self.relation_id, self.user_id)
  end

end