class Board
  include Mongoid::Document
  field :name, type: String
  field :shared, type: Boolean, default: false

  belongs_to  :user
  embeds_many :items
  has_many    :statuses

  validates_presence_of   :name
  validates_uniqueness_of :name

  def add_item(params)
    item = Item.new
    item.title  = params[:title]
    item.status = params[:status]
    
    keyVals = params[:keyVals] || {}
    kv = {}
    keyVals.each do |k, v|
      iKey = v["iKey"]
      iVal = v["iVal"]
      kv[iKey] = iVal
    end
    item.keyVals = kv
    
    self.items.push(item)
    self
  end
end