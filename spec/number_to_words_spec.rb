require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'bigdecimal'

describe "NumberToWords" do
  describe "#as_leva" do
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
  
    it "should work with numbers less than 100, not dividable by 10" do
      42.bg.as_words.should == 'четиридесет и две'
      97.bg.as_words.should == 'деветдесет и седем'
      89.bg.as_words.should == 'осемдесет и девет'
    end
  
    it "should work with numbers less than 1000, divisable by 100" do
      %w[сто двеста триста четиристотин петстотин шестстотин седемстотин осемстотин деветстотин].zip([100, 200, 300, 400, 500, 600, 700, 800, 900]).each do |name, number|
        number.bg.as_words.should == name
      end
    end
  
    it "should work with numbers 100-1000, not dividable by 100" do
      110.bg.as_words.should == 'сто и десет'
      217.bg.as_words.should == 'двеста и седемнадесет'
      420.bg.as_words.should == 'четиристотин и двадесет'
    
      123.bg.as_words.should == 'сто двадесет и три'
    end
  
    it "should work with numbers divisable with 1000" do
      1_000.bg.as_words.should == 'хиляда'
      2_000.bg.as_words.should == 'две хиляди'
      5_000.bg.as_words.should == 'пет хиляди'
      10_000.bg.as_words.should == 'десет хиляди'
      13_000.bg.as_words.should == 'тринадесет хиляди'
      28_000.bg.as_words.should == 'двадесет и осем хиляди'
      100_000.bg.as_words.should == 'сто хиляди'
      673_000.bg.as_words.should == 'шестстотин седемдесет и три хиляди'
    end
  
    it "should work with numbers less than 1 000 000, not divisable with 1000" do
      1_001.bg.as_words.should == 'хиляда и едно'
      1_024.bg.as_words.should == 'хиляда двадесет и четири'
      17_001.bg.as_words.should == 'седемнадесет хиляди и едно'
      24_200.bg.as_words.should == 'двадесет и четири хиляди и двеста'
      65_536.bg.as_words.should == 'шестдесет и пет хиляди петстотин тридесет и шест'
    
      123_456.bg.as_words.should == 'сто двадесет и три хиляди четиристотин петдесет и шест'
    end
  
    it "should work with millions" do
      1_000_000.bg.as_words.should == 'един милион'
      1_000_001.bg.as_words.should == 'един милион и едно'
      2_000_200.bg.as_words.should == 'два милиона и двеста'
      35_000_035.bg.as_words.should == 'тридесет и пет милиона тридесет и пет'
      123_456_789.bg.as_words.should == 'сто двадесет и три милиона четиристотин петдесет и шест хиляди седемстотин осемдесет и девет'
    end
  
    it "should work with big numbers in male gender" do
      121_121_121.bg.as_words(:male).should == 'сто двадесет и един милиона сто двадесет и една хиляди сто двадесет и един'
    end
    
    it "should work with the integer part only" do
      BigDecimal("42").bg.as_words.should == 'четиридесет и две'
      BigDecimal("42.10").bg.as_words.should == 'четиридесет и две'
    end
  end
  
  it "should give numbers as levas" do
    42.bg.as_leva.should == 'четиридесет и два лева и 0 стотинки'
    3.14.bg.as_leva.should == 'три лева и 14 стотинки'
    BigDecimal('3.05').bg.as_leva.should == 'три лева и 5 стотинки'
  end
  
end
