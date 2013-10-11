class FeedbackController < ApplicationController

  def create
    f = Feedback.new({:text => params[:text]})
    if f.save
      render :json => {success: true, message: "Feedback saved. You can close this pop-up."}.to_json
    else
      render :status => 500, :json => {success: false, message: "Feedback could not be saved. Please try again later."}.to_json and return
    end
  end

end