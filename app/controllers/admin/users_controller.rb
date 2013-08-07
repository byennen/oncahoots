class Admin::UsersController < Admin::ApplicationController
  load_and_authorize_resource :user


  def index
    if current_user.super_admin
      @users = User.all
    end
    if current_user.university_admin
      @users = User.where(university_id: current_user.university_id)
    end
    @user = User.new
  end

  def create
    if current_user.super_admin?
      @user = User.new(params[:user])
      @user.add_role :super_admin
    end
    if current_user.university_admin?
      @user = User.new(params[:user])
      @user.update_attributes(:university_id => current_user.university_id)
      @user.add_role :university_admin
    end
    if @user.save
      flash[:notice] = "User was successfully created"
    else
      flash[:error] =  "User was not created"
    end
    redirect_to admin_users_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to admin_users_path, :notice => "User updated."
    else
      redirect_to admin_users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to admin_users_path, :notice => "User deleted."
    else
      redirect_to admin_users_path, :notice => "Can't delete yourself."
    end
  end
end
