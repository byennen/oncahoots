class UpdatesController < ApplicationController

  load_and_authorize_resource
  before_filter :load_updateable

  def index
    @updates = @updateable.updates
  end

  def new
    @update = @updateable.updates.new
  end

  def create
    @update = @updateable.updates.new(params[:update])
    if @update.save
      redirect_to @updateable, notice: 'Update created.'
    else
      redirect_to @updateable, notice: 'Update failed. Please try again.'
    end
  end

  private

  def load_updateable
    resource, id = request.path.split('/')[1, 2]
    @updateable = resource.singularize.classify.constantize.find(id)
  end
end
