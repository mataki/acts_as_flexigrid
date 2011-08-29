require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe ActsAsFlexigrid do
  before :all do
    1.upto(100) {|i| User.create! :name => "user#{'%03d' % i}", :age => (i / 10)}
  end

  describe ".flexigrid" do
    subject { User.flexigrid({ "page" => 1, "rp" => 10}) }
    it "should have specified 3 keys" do
      should have_key(:rows)
      should have_key(:total)
      should have_key(:page)
    end

    it "should 100 as total" do
      subject[:total].should == 100
    end

    it "should 10 data of rows" do
      subject[:rows].should have(10).items
    end
  end
end
