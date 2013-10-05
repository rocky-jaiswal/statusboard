module PagesHelper

  def status_lane_width(size)
    (100 / size - (size*0.1)).to_s + "%"
  end
  
end
