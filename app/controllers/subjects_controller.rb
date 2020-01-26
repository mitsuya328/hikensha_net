class SubjectsController < ApplicationController
  before_action :set_experiment, only: %i(index new create)
  before_action :correct_experimenter, only: :index
  before_action :correct_subject, only: %i(new create)
  
  def index
    @subjects = @experiment.subjects.order(timetable_id: :desc)

    respond_to do |format|
      format.html
      format.csv { send_data @subjects.generate_csv, filename: "#{@experiment.name}の被験者一覧.csv"}
    end
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.experiment == @experiment && @subject.save
      #flash[:success] = "実験への参加申し込みを受け付けました。ご協力ありがとうございます。"
      redirect_to @experiment, success: "実験への参加申込を受け付けました。ご協力ありがとうございます。"
    else
      render 'new'
    end
  end
  
  private

    def set_experiment
      @experiment = Experiment.find(params[:experiment_id])
    end

    def correct_experimenter
      unless current_user?(@experiment.user)
        redirect_to experiment_path(@experiment)
      end
    end

    def correct_subject
      if logged_in? && current_user?(@experiment.user)
        #flash[:danger] = "自分の実験に参加することはできません。"
        redirect_to experiment_path(@experiment), danger: "自分の実験に参加することはできません。"
      end
    end

    def subject_params
      params.require(:subject).permit(:email, :sex, :birth_date, :note, :timetable_id)
    end
end
