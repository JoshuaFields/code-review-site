class TutorialsController < ApplicationController
  def index
    @tutorials = Tutorial.all
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end

  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    if @tutorial.save
      flash[:notice] = "Tutorial Added."
      redirect_to tutorials_path
    else
      flash[:notice] = @tutorial.errors.full_messages[0]
      render :new
    end
  end

  protected

  def tutorial_params
    params.require(:tutorial).permit(:title, :url, :language, :description, :organization, :cost)
  end
end
