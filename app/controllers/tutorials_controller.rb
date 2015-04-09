class TutorialsController < ApplicationController
  before_action :authenticate_user!, except: %i(index show search)
  before_action :authorize_admin!, only: %i(destroy)

  def index
    if params[:tag_name]
      @tutorials = Tutorial.tagged_with(params[:tag_name]).page(params[:page]).per(3)
    elsif params[:newest]
      @tutorials = Tutorial.all.order('created_at desc').page(params[:page]).per(3)
    elsif params[:oldest]
      @tutorials = Tutorial.all.order('created_at asc').page(params[:page]).per(3)
    else
      @tutorials = Tutorial.all.page(params[:page]).per(3)
    end
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    @review = Review.new
  end

  def new
    @tutorial = Tutorial.new
  end

  def edit
    @tutorial = Tutorial.find(params[:id])
    unless current_user == @tutorial.user
      flash[:notice] = "You can only edit your own tutorials!"
      redirect_to tutorials_path
    end
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    @tutorial.user = current_user
    if @tutorial.save
      flash[:notice] = "Tutorial Added."
      redirect_to tutorials_path
    else
      flash[:notice] = @tutorial.errors.full_messages.join("! ")
      render :new
    end
  end

  def update
    @tutorial = Tutorial.find(params[:id])
    if @tutorial.user == current_user && @tutorial.update(tutorial_params)
      redirect_to @tutorial
    else
      flash[:notice] = @tutorial.errors.full_messages.join("! ")
      render :edit
    end
  end

  def destroy
    @tutorial = Tutorial.find(params[:id])
    @tutorial.destroy
    redirect_to tutorials_path
  end

  def search
    @results = Tutorial.select(:id, :title).where(
      "to_tsvector(title) @@ plainto_tsquery(?)", [params[:search]]
    )
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(
      :title, :url, :language, :description, :organization, :cost, :all_tags
    )
  end
end
