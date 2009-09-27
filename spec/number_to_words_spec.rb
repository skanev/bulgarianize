require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NumberToWords" do
  it "should work with simple numbers less than 10" do
    %w{нула едно две три четири пет шест седем осем девет}.each_with_index do |words, number|
      number.bg.as_words.should == words
    end
  end
  
  it "should enable genders with numbers less than 10" do
    numbers = [
      %w{нула нула нула},
      %w{един една едно},
      %w{два две две},
      %w{три три три},
    ]
    
    numbers.each_with_index do |names, number|
      [:male, :female, :neuter].zip(names) do |gender, name|
        number.bg.as_words(gender).should == name
      end
    end
  end
  
  it "should work with numbers 11-19" do
    %w[единадесет дванадесет тринадесет четиринадесет петданесет шестнадесет седемнадесет осемнадесет деветнадесет].zip((11..19).to_a).each do |name, number|
      number.bg.as_words.should == name
    end
  end
  
  it "should work with numbers dividable by 10" do
    %w[десет двадесет тридесет четиридесет петдесет шестдесет седемдесет осемдесет деветдесет].zip([10, 20, 30, 40, 50, 60, 70, 80, 90]).each do |name, number|
      number.bg.as_words.should == name
    end
  end
  
  it "should work with numbers less than 10, not dividable by 10" do
    42.bg.as_words.should == 'четиридесет и две'
    97.bg.as_words.should == 'деветдесет и седем'
    89.bg.as_words.should == 'осемдесет и девет'
  end
end
