class UpdatesController < ApplicationController

  before_filter :load_updateable

  def index
    @updates = @updateable.updates
  end

  def show
    @updates = @updateable.updates.find(params[:id])
    @src = @update.image.url
    @src = "/essets/bg.png" if @src.blank?
    respond_to :js 
  end

  def new
    @update = @updateable.updates.new
  end

  def create
    @update = @updateable.updates.new(params[:update])
    if @update.save
      redirect_to @redirect_path, notice: 'Update created.'
    else
      redirect_to @redirect_path, notice: 'Failed. Please try again.'
    end
  end

  def update
    @update = Update.find(params[:id])
    if @update.update_attributes(params[:update])
      redirect_to @redirect_path, notice: 'Updated!'
    else
      redirect_to @redirect_path, notice: 'Failed. Please try again.'
    end
  end
  
  def destroy
    @update = @updateable.updates.find params[:id]
    @update.destroy
    redirect_to @redirect_path
  end

  private
  def load_updateable
    resource, id = request.path.split('/')[1, 2]
    @updateable = resource.singularize.classify.constantize.find(id)
    @redirect_path =  @updateable.instance_of?(Club) ? university_club_path(@updateable.university, @updateable) : @updateable
  end
end
