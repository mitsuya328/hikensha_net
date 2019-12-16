class SubjectsController < ApplicationController
  def index
    experiment = Experiment.find(params[:experiment_id])
    @subjects = experiment.subjects.all
  end
end
