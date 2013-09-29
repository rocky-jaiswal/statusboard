require 'multi_json'

class StatusesController < ApplicationController
  
  def create
    statuses = params['statuses']
    board_id = params['boardId']

    statuses.each do |status|
      Status.create({name: status, board_id: board_id})
    end

    render :json => {success: true}.to_json and return
  end

end