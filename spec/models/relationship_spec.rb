require 'spec_helper'

describe Relationship do

  let!(:user)  { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:user3) { FactoryGirl.create(:user) }
  
  describe "#exists?" do

    context 'with valid relationship' do

      let!(:relationship) { FactoryGirl.create(:relationship, user_id: user.id, relation_id: user2.id, status: 'pending') }

      it "should return true" do
        expect(Relationship.exists?(user, user2)).to be_true
      end

    end

    context 'without valid relationship' do

      it "should return false" do
        expect(Relationship.exists?(user, user3)).to_not be_true
      end

    end

  end

  context "#reciprocal?" do

    let!(:relationship) { Relationship.request(user, user2) }
    let!(:requestor) { Relationship.find_by_user_id_and_relation_id(user.id, user2.id, 'test') }
    let!(:requestee) { Relationship.find_by_user_id_and_relation_id(user2.id, user.id, 'test') }

    describe 'when both accepted' do

      before do
        relationship.accept!
      end

      it "should be reciprocal?" do
        expect(Relationship.reciprocal?(user, user2)).to be_true
      end

    end

    describe 'when requested' do

      it "should not be reciprocal?" do
        expect(Relationship.reciprocal?(user, user2)).to_not be_true
      end

      it "should be requested" do
        expect(Relationship.requested?(user2, user)).to be_true
      end

    end


    describe 'when declined' do

      before do
        relationship.decline!
      end

      it "should not be reciprocal?" do
        expect(Relationship.reciprocal?(user, user2)).to_not be_true
      end

      it "should be delinced?" do
        expect(Relationship.declined?(user, user2)).to be_true
      end

    end




  end

  context "#requested?" do

  end

  context '#request' do

    let!(:relationship) { Relationship.request(user, user2) }
    let!(:requestor) { Relationship.find_by_user_id_and_relation_id(user.id, user2.id, 'test') }
    let!(:requestee) { Relationship.find_by_user_id_and_relation_id(user2.id, user.id, 'test') }

    it "should create a user relationship that exists" do
       expect(Relationship.exists?(user, user2)).to be_true 
    end

    it "should create a user relation that has a status of requested" do
      expect(requestor.status).to eq('requested')
    end

    subject(:requestee) { Relationship.find_by_user_id_and_relation_id(user2.id, user.id, 'test') }

    it "should create a relationship user that has a status of 'pending'" do
      expect(requestee.status).to eq('pending');
    end

    it "should have a pending relationship for requestee" do
      expect(requestee.pending?).to be_true
    end

    it "should have a requested relationship for requestor" do
      expect(requestor.requested?).to be_true
    end

    it "should have a false relationship for accepted" do
      expect(requestor.accepted?).to_not be_true
    end

    it "should have a false relationship for requestor accepted" do
      expect(requestee.accepted?).to_not be_true
    end

  end

  context "states" do

    let!(:relationship) { Relationship.request(user, user2) }

  end
  
end
