require 'multi_json'

class ItemsController < ApplicationController

  def show
    item = Item.search(params[:id])
    render :json => item.to_json
  end
  
  def create
    board = Board.find(params[:boardId])
    board = board.add_item(params[:status], params[:title], params[:keyVals])
    if board.save
      render :json => board.to_json(:include => {:statuses => {:include => :items, :methods => :lane_width}}) and return
    else
      render :json => {success: false}.to_json and return
    end
  end

  def move
    board = Board.find(params[:boardId])
    res = board.move_item(params[:id], params[:currentStatus], params[:newStatus])
    if res
      render :json => board.to_json(:include => {:statuses => {:include => :items, :methods => :lane_width}}) and return
    else
      render :json => {success: false}.to_json and return
    end
  end

  def destroy
    item = Item.search(params[:id])
    if item && item.delete
      board = Board.find(params[:boardId])
      render :json => board.to_json(:include => {:statuses => {:include => :items, :methods => :lane_width}}) and return
    else
      render :json => {success: false}.to_json and return
    end
  end

end