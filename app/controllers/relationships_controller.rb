class RelationshipsController < ApplicationController


  def create
    @relation = User.find(params[:relationship][:relation_id])
    Relationship.request(current_user, @relation, params[:relationship][:message])
    respond_to do |format|
      format.html { redirect_to user_path(@relation), notice: "A request has been sent to #{@relation.full_name}" }
    end
  end


  def read
    @relationship = Relationship.find(params[:id])
    respond_to do |format|
      format.js { }
    end
  end

  def accept
    @relationship = Relationship.find(params[:id])
    @relationship.accept!
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "You are now contacts with - #{@relationship.relation.full_name}" }
    end
  end

  def decline
    @relationship = Relationship.find(params[:id])
    @relationship.decline!
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "You have declined the contact - #{@relationship.relation.full_name}" }
    end
  end

end
