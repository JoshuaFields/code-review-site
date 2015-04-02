class TutorialsController < ApplicationController
  def index
    @tutorials = Tutorial.all.page(params[:page]).per(10)
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

  def search
    search_term = PGconn.quote_ident(params[:search])
    @results = ActiveRecord::Base.connection.execute("SELECT id, title FROM " \
      "tutorials WHERE to_tsvector(title) @@ plainto_tsquery('#{search_term}')")
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(
      :title, :url, :language, :description, :organization, :cost
    )
  end
end
