require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Proxies" do
  it "should make itself available as String#bg" do
    "Larodi".bg.string.should == "Larodi"
  end
  
  it "should make itself available as Numeric#bg" do
    1.bg.numeric.should == 1
  end
end
