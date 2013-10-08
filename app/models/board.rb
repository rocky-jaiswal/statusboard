class Board
  include Mongoid::Document
  field :name, type: String
  field :shared, type: Boolean, default: false

  belongs_to  :user
  embeds_many :statuses

  validates_presence_of   :name
  validates_uniqueness_of :name

  def add_item(status, title, keyVals)
    status = self.statuses.where(:name => status).first

    item = Item.new
    item.title  = title
    keyVals = keyVals || {}

    kv = {}
    keyVals.each do |k, v|
      iKey = v["iKey"]
      iVal = v["iVal"]
      kv[iKey] = iVal
    end
    item.keyVals = kv
    
    status.items.push(item)
    self
  end

end