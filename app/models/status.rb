class Status
  include Mongoid::Document
  field :name, type: String
  
  embedded_in :board
  embeds_many :items

  validates_presence_of :name

  #Instance methods
  def lane_width
    size = self.board.statuses.size
    (100 / size - (size*0.1)).to_s + "%"
  end

end