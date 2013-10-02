class Item
  include Mongoid::Document
  field :title,  type: String 
  field :status, type: String
  
  embedded_in :board

  validates_presence_of :title
end