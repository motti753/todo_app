class BoardsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_board, only: [:edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]

  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to root_path, notice: '保存できました'
    else
      flash.now[:error] = '保存できません。タイトルと説明を確かめてください'
      render :new
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to board_path(@board), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
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

  def set_board
    @board = current_user.boards.find(params[:id])
  end
end