class RelationshipsController < ApplicationController

  before_filter :find_relationship, except: [:create]

  def create
    @relation = User.find(params[:relationship][:relation_id])
    Relationship.request(current_user, @relation, params[:relationship][:message])
    respond_to do |format|
      format.html { redirect_to user_path(@relation), notice: "A request has been sent to #{@relation.full_name}" }
    end
  end

  def read
    respond_to do |format|
      format.js { }
    end
  end

  def accept
    @relationship.accept!
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "You are now contacts with - #{@relationship.relation.full_name}" }
    end
  end

  def decline
    @relationship.decline!
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "You have declined the contact - #{@relationship.relation.full_name}" }
    end
  end

  def refer
    Rails.logger.debug("@relationship is #{@relationship.inspect}")
    @refer_user = User.find(params[:relationship][:relation_id])
    @refer_relationship = @relationship.recommend!(@refer_user)
    Rails.logger.debug("refer relationship is #{@refer_relationship.inspect}")
    @relationship.decline!
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "You have referred - #{@refer_relationship.relation.full_name}" }
    end
  end

  def destroy
    @relationship.remove!
    respond_to do |format|
      format.html { redirect_to user_contacts_path(current_user), notice: "You have removed the contact - #{@relationship.relation.full_name}" }
    end
  end

  def accept_recommendation
    @relationship.accept_recommendation!
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "You have accepted the recommendation to #{@relationship.relation.full_name}" }
    end
  end

  def decline_recommendation
    @relationship.decline_recommendation!
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "You have declined the recommendation to #{@relationship.relation.full_name}" }
    end
  end

  private

  def find_relationship
    @relationship = Relationship.find(params[:id])
  end

end
