class Status
  include Mongoid::Document
  field :name, type: String
  
  belongs_to :board

  validates_presence_of :name
end