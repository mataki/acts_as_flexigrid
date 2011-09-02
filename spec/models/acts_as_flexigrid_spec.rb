require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe ActsAsFlexigrid do
  before :all do
    1.upto(100) {|i| User.create! :name => "user#{'%03d' % i}", :age => (i / 10)}
  end

  describe ".flexigrid" do
    before do
      @opt = { "page" => 1, "rp" => 10}
    end
    subject { User.flexigrid(@opt) }
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

    describe "Extend args" do
      it "should include second args" do
        action_str = "<a href='/edit'>Edit</a>"
        res = User.flexigrid(@opt, { :action => action_str})
        res[:rows].first[:cell][:action].should == action_str
      end

      it "should include block args" do
        ext_val = "EXT_VAL"
        res = User.flexigrid(@opt) do |obj|
          { :ext_key => ext_val, :site_name => obj.name }
        end
        res[:rows].first[:cell].should have_key(:site_name)
        res[:rows].first[:cell][:ext_key].should == ext_val
      end
    end
  end

  describe ".flexgrid_where" do
    it "should return 100" do
      User.flexigrid_where("name", "001").count.should == 1
    end
    it "should return quated sql" do
      User.flexi
    end
  end
end
