class TutorialsController < ApplicationController
  def index
    @tutorials = Tutorial.all
  end

  def show 
    @tutorial = Tutorial.find(params[:id])
  end
end