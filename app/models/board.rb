class Board
  include Mongoid::Document
  field :name, type: String
  field :shared, type: Boolean, default: false

  belongs_to  :user
  embeds_many :statuses

  validates_presence_of   :name
  validates_uniqueness_of :name

  #Instance methods
  def move_item(item_id, old_status_id, new_status_id)
    old_status = self.statuses.find(old_status_id)
    new_status = self.statuses.find(new_status_id)
    item = old_status.items.find(item_id)

    new_item = item.duplicate
    new_status.items.push(new_item)
    item.delete && new_status.save
  end

  def add_item(status, title, comments, keyVals)
    status = self.statuses.where(:name => status).first
    item = Item.build(title, comments, keyVals)
    status.items.push(item)
    self
  end

end