class ExperimentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def show
    @experiment = Experiment.find(params[:id])
  end

  def new
    @form = ExperimentForm.new
  end

  def create
    @form = ExperimentForm.new(experiment_form_params)
    @form.experiment.user = current_user
    if @form.save
      flash[:success] = "実験を登録しました"
      redirect_to @form.experiment
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @experiment.update(experiment_params)
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
      params.require(:experiment).permit(:name, :description, :deadline, :picture)
    end

    def experiment_form_params
      params.require(:experiment_form).permit(experiment_attributes: [:name, :description, :deadline, :picture],
                                              timetables_attributes: [:start_at])
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @experiment = current_user.experiments.find_by(id: params[:id])
      redirect_to root_url if @experiment.nil?
    end
end
