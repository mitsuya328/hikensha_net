class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @recommend_experiments = current_user.recommend_experiments.order(deadline: :desc).take(5)
    end
    @recent_experiments = Experiment.order(created_at: :desc).take(5)
    @imminent_experiments = Experiment.order(deadline: :asc).take(5)
  end

  def help; end

  def about; end

  def contact; end

  def news; end
end
