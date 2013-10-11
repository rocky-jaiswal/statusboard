class Feedback
  include Mongoid::Document
  field :text, type: String
  
  validates_presence_of :text
end