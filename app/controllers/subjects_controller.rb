class SubjectsController < ApplicationController
  before_action :set_experiment, only: %i(index new create)
  before_action :correct_experimenter, only: :index
  before_action :correct_subject, only: %i(edit update)
  
  def index
    @subjects = @experiment.subjects.order(timetable_id: :desc)
    respond_to do |format|
      format.html
      format.csv { send_data @subjects.generate_csv, filename: "#{@experiment.name}の被験者一覧.csv"}
    end
  end

  def new
    if logged_in?
      @subject = Subject.new(
        email: current_user.email, sex: current_user.sex, birth_date: current_user.birth_date
      )
    else
      @subject = Subject.new
    end
  end

  def create
    @subject = @experiment.subjects.new(subject_params)
    @subject.user = current_user if logged_in?
    if @subject.save
      if logged_in? && !@experiment.user.examinees.include?(current_user)
        @experiment.user.examinees << current_user
      end
      redirect_to @experiment, success: "実験への参加申込を受け付けました。ご協力ありがとうございます。"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @subject.update(subject_params)
      redirect_to @subject.experiment, success: "申込み情報を更新しました"
    else
      render 'edit'
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
      @subject = current_user.subjects.find(params[:id])
      redirect_to root_url if @subject.nil?
      @experiment = @subject.experiment
    end

    def subject_params
      params.require(:subject).permit(:email, :sex, :birth_date, :note, :timetable_id)
    end
end
