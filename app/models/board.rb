class Board
  include Mongoid::Document
  field :name, type: String
  field :shared, type: Boolean, default: false

  belongs_to  :user
  embeds_many :statuses

  validates_presence_of   :name
  validates_uniqueness_of :name

  def self.move_item(board_id, item_id, old_status_id, new_status_id)
    board = Board.find(board_id)
    old_status = board.statuses.find(old_status_id)
    new_status = board.statuses.find(new_status_id)
    item = old_status.items.find(item_id)

    new_item = Item.new({:title => item.title, :keyVals => item.keyVals})
    new_status.items.push(new_item)
    item.delete 
    new_status.save
  end

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