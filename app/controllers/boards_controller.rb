class BoardsController < ApplicationController
  
  def index
    @boards = current_user.boards
  end

  def show
    @board = Board.find(params[:id])
    if request.xhr?
      render :json => @board.to_json(:include => {:statuses => {:include => :items}}) and return
    end
  end

  def new
  end

  def create
    b = Board.new({name: params[:board_name]})
    b.shared = true if params[:board_shared]
    b.user = current_user
    
    if b.save
      render :json => {success: true, id: b.id}.to_json and return
    else
      render :json => {success: false, errors: b.errors}.to_json and return
    end
  end

end