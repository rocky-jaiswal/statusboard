class Item
  include Mongoid::Document
  field :title,  type: String 
  field :keyVals, type: Hash
  field :comments,  type: String 
  
  embedded_in :status

  validates_presence_of :title

  #Instance methods
  def duplicate
    Item.new({:title => self.title, :keyVals => self.keyVals, comments: self.comments})
  end

  #Class methods
  def self.build(title, comments, keyVals)
    item = Item.new
    item.title  = title
    item.comments  = comments || ""
    keyVals = keyVals || {}
    item.keyVals = keyVals.each_with_object({}) do |(k, v), o|
      o[v["iKey"]] = v["iVal"]
    end || {}
    item
  end

  def self.search(user, id)
    item = nil
    user.boards.each do |b|
      b.statuses.each do |s|
        s.items.each do |i|
          item = i if i.id.to_s == id
        end
      end
    end
    item
  end

end