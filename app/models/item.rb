class Item
  include Mongoid::Document
  field :title,  type: String 
  field :status, type: String
  field :keyVals, type: Hash
  
  embedded_in :board

  validates_presence_of :title
  validates_presence_of :status
end