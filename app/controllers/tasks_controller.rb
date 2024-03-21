class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @board = Board.find(params[:board_id])
    @tasks = @board.tasks
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    @task.update(user_id: "#{current_user.id}")
    if @task.save
      redirect_to board_tasks_path(@task.board_id), notice: '保存できました', status: :see_other
    else
      flash.now[:error] = '保存できません。タイトルと説明を確かめてください'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to board_task_path(@task.id), notice: '更新しました', status: :see_other
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to board_tasks_path(board_id: task.board_id), status: :see_other
  end

  private
  def task_params
    param = params.require(:task).permit(:name, :description, :eyecatch)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end