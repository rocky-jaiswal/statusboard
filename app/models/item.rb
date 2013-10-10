class Item
  include Mongoid::Document
  field :title,  type: String 
  field :keyVals, type: Hash
  
  embedded_in :status

  validates_presence_of :title

  #Instance methods
  def duplicate
    Item.new({:title => self.title, :keyVals => self.keyVals})
  end

  #Class methods
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