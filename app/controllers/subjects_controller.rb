class SubjectsController < ApplicationController
  before_action :set_experiment, only: [:index, :new, :create]
  def index
    #experiment = Experiment.find(params[:experiment_id])
    @subjects = @experiment.subjects.order(timetable_id: :desc)
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params) # issue timetable_idが@experimentに属さない場合エラーにする
    if @subject.save
      flash[:success] = "実験への参加申し込みを受け付けました。ご協力ありがとうございます。"
      redirect_to @experiment
    else
      render 'new'
    end
  end
  
  private

    def set_experiment
      @experiment = Experiment.find(params[:experiment_id])
    end

    def subject_params
      params.require(:subject).permit(:email, :sex, :birth_date, :note, :timetable_id)
    end
end
