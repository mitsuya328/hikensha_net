class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_experiments = current_user.feed.order(deadline: :desc).take(8)
    end
    @recent_experiments = Experiment.order(created_at: :desc).take(8)
    @imminent_experiments = Experiment.order(deadline: :asc).take(8)
  end

  def help
  end

  def about
  end

  def contact
  end

  def news
  end
end
