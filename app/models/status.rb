class Status
  include Mongoid::Document
  field :name, type: String
  
  embedded_in :board
  embeds_many :items

  validates_presence_of :name

end