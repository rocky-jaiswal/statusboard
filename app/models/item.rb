class Item
  include Mongoid::Document
  field :status, type: String
  
  embedded_in :board
end