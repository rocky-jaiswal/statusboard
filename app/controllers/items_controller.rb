require 'multi_json'

class ItemsController < ApplicationController
  
  def create
    @board = Board.find(params[:boardId])
    @board = @board.add_item(params[:status], params[:title], params[:keyVals])
    if @board.save
      render :json => @board.to_json(:include => {:statuses => {:include => :items, :methods => :lane_width}}) and return
    else
      render :json => {success: false}.to_json and return
    end
  end

  def move
    res = Board.move_item(params[:boardId], params[:id], params[:currentStatus], params[:newStatus])
    if res
      @board = Board.find(params[:boardId])
      render :json => @board.to_json(:include => {:statuses => {:include => :items, :methods => :lane_width}}) and return
    else
      render :json => {success: false}.to_json and return
    end
  end

end