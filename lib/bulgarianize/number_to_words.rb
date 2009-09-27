module Bulgarianize
  class Condition
    def initialize(&block)
      @block = block
    end
    
    def ===(n)
      @block[n]
    end
  end
  
  module NumberToWords
    MALE_DIGITS = %w[нула един два три четири пет шест седем осем девет]
    FEMALE_DIGITS = %w[нула една две три четири пет шест седем осем девет]
    NEUTER_DIGITS = %w[нула едно две три четири пет шест седем осем девет]
    NAMES_11_TO_19 = %w[единадесет дванадесет тринадесет четиринадесет петданесет шестнадесет седемнадесет осемнадесет деветнадесет]
    MULTIPLES_OF_10 = %w[десет двадесет тридесет четиридесет петдесет шестдесет седемдесет осемдесет деветдесет]
    HUNDREDS = %w[сто двеста триста четиристотин петстотин шестстотин седемстотин осемстотин деветстотин]
    
    def as_words(gender = :neuter)
      words_for(self.numeric, gender)
    end
    
    protected
  
      def words_for(n, gender)
        case n
          when 0..9 then {:male => MALE_DIGITS, :female => FEMALE_DIGITS, :neuter => NEUTER_DIGITS}.fetch(gender).fetch(n)
          when 11..19 then NAMES_11_TO_19.fetch(n - 11)
          when 10, 20, 30, 40, 50, 60, 70, 80, 90 then MULTIPLES_OF_10.fetch(n / 10 - 1)
          when 21..99 then join_words words_for(whole_part(n, 10), gender), words_for(n % 10, gender)
          when 100, 200, 300, 400, 500, 600, 700, 800, 900 then HUNDREDS.fetch(n / 100 - 1)
          when 101..999 then join_words words_for(whole_part(n, 100), gender), words_for(n % 100, gender)
          when 1000 then 'хиляда'
          when cond { |n| n % 1_000 == 0 and n < 1_000_000 } then "#{words_for(n / 1000, :female)} хиляди"
          when 1_001..999_999 then join_words words_for(whole_part(n, 1000), gender), words_for(n % 1000, gender)
          when 1_000_000 then 'един милион'
          when cond { |n| n % 1_000_000 == 0 and n < 1_000_000_000_000 } then "#{words_for(n / 1_000_000, :male)} милиона"
          when 1_000_001..999_999_999_999 then join_words words_for(whole_part(n, 1_000_000), gender), words_for(n % 1_000_000, gender)
          else n.to_s
        end
      end
      
      def join_words(a, b)
        if b.include? ' и '
          "#{a} #{b}"
        else
          "#{a} и #{b}"
        end
      end
      
      def cond(&block)
        Condition.new(&block)
      end
      
      def whole_part(number, base)
        (number / base) * base
      end
  end
  
  NumericProxy.send :include, NumberToWords
end
