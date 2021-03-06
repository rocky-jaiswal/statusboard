require 'multi_json'

class ItemsController < ApplicationController

  def show
    item = Item.search(current_user, params[:id])
    render :json => item.to_json
  end
  
  def create
    board = Board.find(params[:boardId])
    authorize(board)
    
    board = board.add_item(params[:status], params[:title], params[:comments], params[:keyVals])
    
    if board.save
      render :json => board.to_json(:include => {:statuses => {:include => :items, :methods => :lane_width}}) and return
    else
      render :status => 500, :json => {success: false, message: "Error saving item! Plase try again later."}.to_json and return
    end
  end

  def move
    board = Board.find(params[:boardId])
    authorize(board)
    
    res = board.move_item(params[:id], params[:currentStatus], params[:newStatus])
    if res
      render :json => board.to_json(:include => {:statuses => {:include => :items, :methods => :lane_width}}) and return
    else
      render :status => 500, :json => {success: false, message: "Error moving item! Please try again later."}.to_json and return
    end
  end

  def destroy
    item = Item.search(current_user, params[:id])
    
    if item && item.delete
      board = Board.find(params[:boardId])
      render :json => board.to_json(:include => {:statuses => {:include => :items, :methods => :lane_width}}) and return
    else
      render :status => 500, :json => {success: false, message: "Error deleting item! Please try again later."}.to_json and return
    end
  end

end