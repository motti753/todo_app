class BoardsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      # 後々board_path(index)へのパスに修正
      redirect_to new_board_path, notice: '保存できました'
    else
      flash.now[:error] = '保存できません。タイトルと説明を確かめてください'
      render :new
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to root_path, status: :see_other
  end

  private
  def board_params
    params.require(:board).permit(:name, :description)
  end
end