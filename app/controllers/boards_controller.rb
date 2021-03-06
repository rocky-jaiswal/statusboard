class BoardsController < ApplicationController
  
  def index
    @boards = current_user.boards
  end

  def show
    @board = Board.find(params[:id])
    authorize(@board)
    if request.xhr?
      render :json => @board.to_json(:include => {:statuses => {:include => :items, :methods => :lane_width}}) and return
    end
  end

  def share
    @board = Board.find(params[:id])
    if request.xhr? && @board.shared
      render :json => @board.to_json(:include => {:statuses => {:include => :items, :methods => :lane_width}}) and return
    end
  end

  def new
  end

  def create
    b = Board.new({name: params[:board_name]})
    b.shared = true if params[:board_shared]
    b.user = current_user
    
    if b.save
      render :json => {success: true, id: b.id, name: b.name}.to_json and return
    else
      render :status => 500, :json => {success: false, errors: b.errors}.to_json and return
    end
  end

  def edit
  end

  def delete
    board = Board.find(params[:id])
    authorize(board)
    if board.delete
      redirect_to boards_path, notice: "Board deleted successfully!"
    else
      render :status => 500, :json => {success: false, message: "error deleting board"}.to_json and return
    end
  end

end