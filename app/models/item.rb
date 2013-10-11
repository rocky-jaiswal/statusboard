class Item
  include Mongoid::Document
  field :title,  type: String 
  field :keyVals, type: Hash
  field :comments,  type: String 
  
  embedded_in :status

  validates_presence_of :title

  #Instance methods
  def duplicate
    Item.new({:title => self.title, :keyVals => self.keyVals})
  end

  #Class methods
  def self.build(title, comments, keyVals)
    item = Item.new
    item.title  = title
    item.comments  = comments || ""
    keyVals = keyVals || {}

    kv = {}
    keyVals.each do |k, v|
      iKey = v["iKey"]
      iVal = v["iVal"]
      kv[iKey] = iVal
    end
    item.keyVals = kv
    item
  end

  def self.search(id)
    item = nil
    Board.all.each do |b|
      b.statuses.each do |s|
        s.items.each do |i|
          item = i if i.id.to_s == id
        end
      end
    end
    item
  end

end