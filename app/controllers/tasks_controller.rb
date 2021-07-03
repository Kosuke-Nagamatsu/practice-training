class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.order(time_limit: :DESC)
    elsif params[:sort_priority]
      @tasks = Task.order(:priority)
    else
      @tasks = Task.order(created_at: :DESC)
    end
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status] != '選択してください'
        @tasks = Task.fuzzy_by_title(params[:task][:title]).full_by_status(params[:task][:status])
      elsif params[:task][:title].present? && params[:task][:status] == '選択してください'
        @tasks = Task.fuzzy_by_title(params[:task][:title])
      elsif params[:task][:status] != '選択してください'
        @tasks = Task.full_by_status(params[:task][:status])
      end
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
    params.require(:task).permit(:title, :content, :time_limit, :status, :priority)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
