class BoardsController < ApplicationController
  
  def index
    @boards = current_user.boards
  end

  def new
  end

  def create
    b = Board.new({name: params[:board_name]})
    b.user = current_user
    b.shared = true if params[:board_shared]
    
    if b.save
      render :json => {success: true, id: b.id}.to_json and return
    else
      render :json => {success: false, errors: b.errors}.to_json and return
    end
  end

end