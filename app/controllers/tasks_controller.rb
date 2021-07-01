class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.order(time_limit: :DESC)
    else
      @tasks = Task.order(created_at: :DESC)
    end
  end
  def new
    @task = Task.new
  end
  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end
  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "新規作成しました！"
      else
        render :new
      end
    end
  end
  def show
  end
  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "更新しました！"
    else
      render :edit
    end
  end
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "削除しました！"
  end
  private
  def task_params
    params.require(:task).permit(:title, :content, :time_limit, :status)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
