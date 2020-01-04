class ExperimentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def show
    @experiment = Experiment.find(params[:id])
  end

  def new
    @experiment = Experiment.new
    @experiment.timetables.build
  end

  def create
    @experiment = Experiment.new(experiment_params)
    @experiment.user = current_user
    @experiment.timetables.each do |timetable|
      timetable.number_of_subjects = @experiment.number_of_subjects
    end
    if @experiment.save
      flash[:success] = "実験を登録しました"
      redirect_to @experiment
    else
      render 'new'
    end
  end

  def edit
    @experiment = Experiment.find(params[:id])
    @experiment.number_of_subjects = @experiment.timetables.first.number_of_subjects if @experiment.timetables.any?
  end

  def update
    @experiment = Experiment.find(params[:id])
    if @experiment.update_attributes(experiment_params)
      flash[:success] = "実験内容を更新しました"
      redirect_to @experiment
    else
      render 'edit'
    end
  end

  def destroy
    @experiment.destroy
    flash[:success] = "「#{@experiment.name}」を削除しました。"
    redirect_to root_path
  end

  private

    def experiment_params
      params
      .require(:experiment)
      .permit(
        Experiment::REGISTRABLE_ATTRIBUTES +
        [timetables_attributes: Timetable::REGISTRABLE_ATTRIBUTES]
      )
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @experiment = current_user.experiments.find_by(id: params[:id])
      redirect_to root_url if @experiment.nil?
    end
end
