class Board
  include Mongoid::Document
  field :name, type: String
  field :shared, type: Boolean, default: false

  belongs_to  :user
  embeds_many :items
  has_many    :statuses

  validates_presence_of   :name
  validates_uniqueness_of :name
end