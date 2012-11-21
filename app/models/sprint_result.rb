class SprintResult < ActiveRecord::Base
  include Statistics

  attr_accessible :person_days_actual, :person_days_planned, :points_actual, :points_planned, :sprint_id, :team_id

  validates :person_days_planned, :presence => true
  validates :points_planned, :presence => true
  validates :sprint_id, :presence => true
  validates :team_id, :presence => true

  validates :person_days_actual, :presence => true, 
    :if => :person_days_and_points_actual_present? 
  validates :points_actual, :presence => true,
    :if => :person_days_and_points_actual_present? 

  belongs_to :team
  belongs_to :sprint

  before_save do
    self.points_per_person_day_planned = 
        points_planned.to_f / person_days_planned.to_f

    if !person_days_actual.nil?
      self.points_per_person_day_actual =  
          points_actual.to_f / person_days_actual.to_f
      self.percent_points_completed = 
          (points_actual.to_f / points_planned.to_f) * 100
      self.percent_person_days_achieved = 
          (person_days_actual.to_f / person_days_planned.to_f) * 100
    end
  end

  after_save do

    if !person_days_actual.nil?
      update_stats(Team.find(team_id))  
    end

  end

  def person_days_and_points_actual_present?
    (!person_days_actual.nil? && points_actual.nil?) ||
      (person_days_actual.nil? && !points_actual.nil?)
  end

  # this will no longer scale when a team has > ~1000 sprint results
  def update_team_stats

    #  https://gist.github.com/e51535002e609895586d
   
    team = Team.find(team_id)
    sprint_results = team.sprint_results.all


    metrics = {
      :points_planned                 => [],
      :points_actual                  => [],
      :person_days_planned            => [],
      :person_days_actual             => [],
      :points_per_person_day_planned  => [],
      :points_per_person_day_actual   => [],
      :percent_points_completed       => [],
      :percent_person_days_achieved   => []
    }

    # iterate over all attributes and build arrays containing all result values
    # calculate mean and standard deviation for each set of result values
    # assemble into an array
    statistics = metrics.inject({}) do |memo, (attribute_name, results)|
      sprint_results.each do |result|
       results << result.send(attribute_name)
      end
      mean, std_dev = mean_and_standard_deviation(results)
      memo[attribute_name] = {}
      memo[attribute_name][:mean] = mean
      memo[attribute_name][:std_dev] = std_dev
      memo
    end

    team_stats = team.team_stats
    # now save to teams stats
    statistics.each do |attribute_name, stats|
      team_stats.send("#{attribute_name}_mean=", stats[:mean])
      team_stats.send("#{attribute_name}_std_dev=", stats[:std_dev])
    end

    team_stats.save

  end

  def update_stats(team)

    metrics = {
      :points_planned                 => [],
      :points_actual                  => [],
      :person_days_planned            => [],
      :person_days_actual             => [],
      :points_per_person_day_planned  => [],
      :points_per_person_day_actual   => [],
      :percent_points_completed       => [],
      :percent_person_days_achieved   => []
    }

    TeamStats.dimensions.each do |dimension|
      results = get_sprint_results(team, dimension)
      statistics = calculate_mean_and_std_dev(metrics, results)
      save_team_stats(team, statistics, dimension) 
    end

  end


  def get_sprint_results(team, dimension)

    case dimension
    when :last_5
      results = get_most_recent_sprint_results(team, 5)
    when :last_3
      results = get_most_recent_sprint_results(team, 3)
    else
      results = team.sprint_results.where(["points_actual IS NOT ?", nil])
    end
  
    return results 
  end

  def get_most_recent_sprint_results(team, limit)

    today = Date.today

    results = team.sprint_results.joins(:sprint).where(["sprints.end < ? AND points_actual IS NOT ?", today, nil]).order("sprints.end DESC").limit(limit)

  end

  def calculate_mean_and_std_dev(metrics, sprint_results)
    # calculate mean and standard deviation for each set of result values
    # assemble into an array

    statistics = metrics.inject({}) do |memo, (attribute_name, results)|
      sprint_results.each do |result|
       results << result.send(attribute_name)
      end
      mean, std_dev = mean_and_standard_deviation(results)
      memo[attribute_name] = {}
      memo[attribute_name][:mean] = mean
      memo[attribute_name][:std_dev] = std_dev
      memo
    end

  end 

  def save_team_stats(team, statistics, dimension)

    case dimension
    when :last_3
      str = '_last_3'
    when :last_5
      str = '_last_5'
    else
      str = '' 
    end

    team_stats = team.team_stats
    # now save to teams stats
    statistics.each do |attribute_name, stats|
      team_stats.send("#{attribute_name}_mean#{str}=", stats[:mean])
      team_stats.send("#{attribute_name}_std_dev#{str}=", stats[:std_dev])
    end

    team_stats.save
  end

end
