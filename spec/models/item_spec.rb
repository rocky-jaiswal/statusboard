require 'spec_helper'

describe Item do

  it "builds an item properly" do
    key_vals = {"0"=>{"iKey"=>"Points", "iVal"=>"5"}, "1"=>{"iKey"=>"Priority", "iVal"=>"High"}}
    item = Item.build("t1", "c1", key_vals)
    expect(item.keyVals).to eq({"Points" => "5", "Priority" => "High"})
  end

  it "builds an item properly when no key vals are assigned" do
    key_vals = nil
    item = Item.build("t1", "c1", key_vals)
    expect(item.keyVals).to eq({})
  end

end