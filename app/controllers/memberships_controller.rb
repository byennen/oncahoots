class MembershipsController < ApplicationController

  before_filter :find_university, except: [:new]
  before_filter :find_club, except: [:new]
  before_filter :find_membership, except: [:new, :create, :make_admin]

  def new
    @user_invitation = Membership.new(:invitation_token => params[:invitation_token])
  end

  def create
    @membership = Membership.new(user_id: current_user.id, club_id: @club.id)
    if @membership.save
      redirect_to university_club_path(@university, @club), notice: 'Membership was successfully created.'
    else
      redirect_to university_club_path(@university, @club), notice: 'Membership failed.'
    end
  end

  def make_admin
    @membership = @club.memberships.find_by_user_id(params[:membership][:user_id])
    @membership.title = params[:membership][:title]
    @membership.admin = true
    if @membership.save
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Member - #{@membership.user.full_name} is now an admin" }
      end
    end
  end

  def remove_admin
    if @membership.update_attribute(:admin, false)
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Member - #{@membership.user.full_name} admin privileges have been removed" }
      end
    end
  end

  def destroy
    if @membership.destroy
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Member - #{@membership.user.full_name} has been deleted" }
      end
    end
  end

  private

  def find_university
    @university = University.find(params[:university_id])
  end

  def find_club
    @club = @university.clubs.find(params[:club_id])
  end

  def find_membership
    @membership = @club.memberships.find(params[:id])
  end

end
