class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.includes(:team_stats)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    the_team = Team.find(params[:id])
    team_stats = the_team.team_stats

    today = Date.today
    # we want to show results of last 5 sprints
    results = 
       the_team
        .sprint_results
        .joins(:sprint)
        .where(["sprints.end < ? AND points_actual IS NOT ?", today, nil])
        .order("sprints.end DESC")
        .includes(:sprint)
        .limit(5)

    # these are the metrics we will show, with row names
    metrics = {
      :points_planned                 => ["Pts planned"],
      :points_actual                  => ["Pts actual"],
      :person_days_planned            => ["Person days planned"],
      :person_days_actual             => ["Person days actual"],
      :points_per_person_day_planned  => ["Pts/Person day planned"],
      :points_per_person_day_actual   => ["Pts/Person day actual"],
      :percent_points_completed       => ["% Pts completed"],
      :percent_person_days_achieved   => ["% Person days achieved"]
    }

    # all stats as a table, passed to view
    @table = {:headers => [""], :rows => []}

    # get table headers ie. sprint names from results
    results.each { |r| @table[:headers] << r.sprint.name }
    TeamStats.dimensions.each do |dimension|
      case dimension
      when :last_3
        @table[:headers] << "&oslash; < 3" 
        @table[:headers] << "&sigma; < 3" 
      when :last_5
        @table[:headers] << "&oslash; < 5" 
        @table[:headers] << "&sigma; < 5" 
      else
        @table[:headers] << "&oslash;" 
        @table[:headers] << "&sigma;" 
      end
    end

    # fill in the rows with stats
    # not sure I like this
    @table[:rows] = 
      metrics.inject([]) do | memo, (attribute_name, array) |
        results.each do |result|
          array << result.send(attribute_name).round(2)
        end
        TeamStats.dimensions.each do |dimension|
          case dimension
          when :last_3
            str = '_last_3'
          when :last_5
            str = '_last_5'
          else
            str = '' 
          end
          mean = team_stats.send("#{attribute_name}_mean#{str}")
          std_dev = team_stats.send("#{attribute_name}_std_dev#{str}")
          mean = mean.round(2) if !mean.nil? 
          std_dev = std_dev.round(2) if !std_dev.nil?
          array << mean 
          array << std_dev
        end
        memo << array
      end

    # will run into problems if team has results for more than one current sprint
    # consider current sprint helper method
    sprint_result = 
      the_team
        .sprint_results
        .joins(:sprint)
        .where(["sprints.end >= ? AND sprints.start <= ?", today, today])
        .includes(:sprint)
        .limit(1)
    
    # get out of array
    @current_sprint_result = sprint_result.shift

    #if !@current_sprint_result.empty? 
    #  @current_sprint = Sprint.find(@current_sprint_result.sprint_id)
    #end

    @team = the_team
    #team = Team.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end
end
