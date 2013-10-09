require 'spec_helper'

describe Board do

  it "show move items between status lanes properly" do
    b = Board.create({name: "b1"})
    status1 = Status.new({name: "s1"})
    status2 = Status.new({name: "s2"})
    item = Item.new({title: "i1"})

    status1.items << item
    b.statuses << status1
    b.statuses << status2
    b.save

    Board.move_item(b.id, item.id, status1.id, status2.id)

    Board.find(b.id).statuses.find(status1.id).items.count.should == 0
    Board.find(b.id).statuses.find(status2.id).items.count.should == 1
  end

end