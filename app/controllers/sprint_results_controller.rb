class SprintResultsController < ApplicationController
  # GET /sprint_results
  # GET /sprint_results.json
  def index
    @sprint_results = SprintResult.includes(:team, :sprint)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sprint_results }
    end
  end

  # GET /sprint_results/1
  # GET /sprint_results/1.json
  def show
    @sprint_result = SprintResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sprint_result }
    end
  end

  # GET /sprint_results/new
  # GET /sprint_results/new.json
  def new
    @sprint_result = SprintResult.new

    @teams = Team.all
    @sprints = Sprint.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sprint_result }
    end
  end

  # GET /sprint_results/1/edit
  def edit
    @sprint_result = SprintResult.find(params[:id])

    @teams = Team.all
    @sprints = Sprint.all
  end

  # POST /sprint_results
  # POST /sprint_results.json
  def create
    @sprint_result = SprintResult.new(params[:sprint_result])

    respond_to do |format|
      if @sprint_result.save
        format.html { redirect_to @sprint_result, notice: 'Sprint result was successfully created.' }
        format.json { render json: @sprint_result, status: :created, location: @sprint_result }
      else
        format.html { render action: "new" }
        format.json { render json: @sprint_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sprint_results/1
  # PUT /sprint_results/1.json
  def update
    @sprint_result = SprintResult.find(params[:id])

    respond_to do |format|
      if @sprint_result.update_attributes(params[:sprint_result])
        format.html { redirect_to @sprint_result, notice: 'Sprint result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sprint_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sprint_results/1
  # DELETE /sprint_results/1.json
  def destroy
    @sprint_result = SprintResult.find(params[:id])
    @sprint_result.destroy

    respond_to do |format|
      format.html { redirect_to sprint_results_url }
      format.json { head :no_content }
    end
  end
end
