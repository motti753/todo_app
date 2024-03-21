class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    task = Task.find(params[:task_id])
    @comment = task.comments.build
  end

  def create
    task = Task.find(params[:task_id])
    @comment = task.comments.build(comment_params)
    @comment.update(user_id: "#{current_user.id}")
    @comment.update(task_id: "#{task.id}")
    if @comment.save
      redirect_to board_tasks_path(task.board_id), notice: '保存できました', status: :see_other
    else
      flash.now[:error] = '保存できません。内容を確かめてください'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end