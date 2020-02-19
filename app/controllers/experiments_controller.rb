class ExperimentsController < ApplicationController
  before_action :logged_in_user, only: %i(new create edit update destroy)
  before_action :correct_user,   only: %i(edit update destroy)

  def index
    @experiments = @q.result(distinct: true).order(deadline: :asc).paginate(page: params[:page])
  end

  def show
    @experiment = Experiment.find(params[:id])
  end

  def new
    @experiment = Experiment.new
    @experiment.timetables.build
  end

  def create
    @experiment = current_user.experiments.new(experiment_params)
    @experiment.timetables.each do |timetable|
      timetable.number_of_subjects = @experiment.number_of_subjects
    end
    if @experiment.save
      redirect_to @experiment, success: "実験を登録しました"
    else
      render 'new'
    end
  end

  def edit
    @experiment.number_of_subjects = @experiment.timetables.first.number_of_subjects if @experiment.timetables.any?
  end

  def update
    if @experiment.update(experiment_params)
      redirect_to @experiment, success: "実験内容を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @experiment.destroy
    redirect_to root_path, success: "「#{@experiment.name}」を削除しました。"
  end

  private

    def experiment_params
      params
      .require(:experiment)
      .permit(
        *Experiment::REGISTRABLE_ATTRIBUTES,
        timetables_attributes: Timetable::REGISTRABLE_ATTRIBUTES
      )
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @experiment = current_user.experiments.find_by(id: params[:id])
      redirect_to root_url if @experiment.nil?
    end
end
