class Item
  include Mongoid::Document
  field :title,  type: String 
  field :keyVals, type: Hash
  
  embedded_in :status

  validates_presence_of :title
end