require 'multi_json'

class ItemsController < ApplicationController
  
  def create
    @board = Board.find(params[:boardId])
    @board = @board.add_item(params)
    if @board.save
      render :partial => "boards/board" and return
    else
      render :json => {success: false}.to_json and return
    end
  end

end