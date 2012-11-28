class StaticPagesController < ApplicationController
  def home

    today = Date.today

    @current_sprint_results = 
      SprintResult
        .joins(:sprint)
        .where(["sprints.end >= ? AND sprints.start <= ?", today, today])
        .order("sprints.id ASC, sprints.start ASC")
        .includes(:sprint, :team)

    respond_to do |format|
      format.html 
      format.json { render json: @current_sprint_results}
    end

    
  end

  def help
  end

  def about 
  end
end
