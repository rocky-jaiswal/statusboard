require 'multi_json'

class StatusesController < ApplicationController
  
  def create
    statuses = params['statuses']
    board_id = params['boardId']
    board = Board.find(board_id)

    statuses.each do |status|
      s = Status.new({name: status})
      board.statuses << s
    end

    if board.save
      render :json => {success: true}.to_json and return
    else
      render :json => {success: false}.to_json and return
    end
  end

end