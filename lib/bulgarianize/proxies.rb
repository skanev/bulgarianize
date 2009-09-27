module Bulgarianize
  class StringProxy
    attr_accessor :string
  
    def initialize(string)
      @string = string
    end
  end
  
  class NumericProxy
    attr_accessor :numeric
    
    def initialize(numeric)
      @numeric = numeric
    end
  end
end

class Numeric
  def bg
    Bulgarianize::NumericProxy.new(self)
  end
end

class String
  def bg
    Bulgarianize::StringProxy.new(self)
  end
end