class Admin::UniversitiesController < Admin::ApplicationController

  def index
    @universities = University.all
  end

  def new
    @university = University.new
  end

  def edit
    @university = University.find(params[:id])
  end

  def create
    @university = University.new(params[:university])
    if @university.save
      redirect_to admin_universities_path, notice: 'University was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @university = University.find(params[:id])
    if @university.update_attributes(params[:university])
      redirect_to admin_universities_path, notice: 'University was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @university = University.find(params[:id])
    @university.destroy
    redirect_to admin_universities_url
  end
end
