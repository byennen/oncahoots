class ClubsController < ApplicationController
  layout "club"

  before_filter :authenticate_user!, except: [:show]
  before_filter :ensure_user_university, except: [:show]

  def show
    @university = University.find(params[:university_id])
    @club = @university.clubs.find(params[:id])
    @membership = Membership.new
    @members = @club.users
    @memberships = @club.memberships
    @current_membership = @club.memberships.find_by_user_id(current_user.id)
    @admins = @club.memberships.where(admin: true)
    @non_admins = @club.memberships.where("admin is NULL").all.map(&:user)
    Rails.logger.debug("non admins are #{@non_admins.inspect}")
  end

  def new
    @club = @university.clubs.new
  end

  def create
    @club = @university.clubs.new(params[:club])
    @club.user_id = current_user.id
    @just_created = true
    #@club.memberships.create(user_id: current_user.id, admin: true)
    if @club.save
      @club.memberships.create(user_id: current_user.id, admin: true)
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club) }
      end
    else
      respond_to do |format|
        format.html { render action: :new }
      end
    end
  end

  def edit
    @club = @university.clubs.find(params[:id])
  end

  def update
    @club = @university.clubs.find(params[:id])
    @club.attributes = params[:club]
    if @club.save
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club) }
      end
    end
  end

  def transfer_ownership
    @club = @university.clubs.find(params[:id])
    @user = User.find(@club.user_id)
    @membership = @club.memberships.find_by_user_id(@user.id)
    @membership.admin = false
    @new_owner = User.find(params[:club][:user_id])
    @club.user_id = params[:club][:user_id]
    if @membership.save && @club.save
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Ownership transferred to #{@new_owner.full_name}" }
      end
    end
  end

  private

    def ensure_user_university
      @university = University.find(params[:university_id])
      unless current_user.university == @university
        redirect_to university_path(params[:university_id])
      else
        return true
      end
    end
end
