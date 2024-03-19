class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @board = Board.find(params[:board_id])
    @tasks = @board.tasks
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
      # 後々indexへのパスに修正
      # redirect_to board_tasks_path, notice: '保存できました'
      redirect_to root_path, notice: '保存できました', status: :see_other
    else
      flash.now[:error] = '保存できません。タイトルと説明を確かめてください'
      render :new
    end
  end

  private
  def task_params
    param = params.require(:task).permit(:name, :description)
  end
end