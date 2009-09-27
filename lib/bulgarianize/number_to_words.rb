module Bulgarianize
  module NumberToWords
    MALE_DIGITS = %w[нула един два три четири пет шест седем осем девет]
    FEMALE_DIGITS = %w[нула една две три четири пет шест седем осем девет]
    NEUTER_DIGITS = %w[нула едно две три четири пет шест седем осем девет]
    NAMES_11_TO_19 = %w[единадесет дванадесет тринадесет четиринадесет петданесет шестнадесет седемнадесет осемнадесет деветнадесет]
    MULTIPLES_OF_10 = %w[десет двадесет тридесет четиридесет петдесет шестдесет седемдесет осемдесет деветдесет]
    
    def as_words(gender = :neuter)
      words_for(self.numeric, gender)
    end
    
    protected
      def words_for(n, gender)
        case n
          when 0..9 then {:male => MALE_DIGITS, :female => FEMALE_DIGITS, :neuter => NEUTER_DIGITS}.fetch(gender).fetch(n)
          when 11..19 then NAMES_11_TO_19.fetch(n - 11)
          when 10, 20, 30, 40, 50, 60, 70, 80, 90 then MULTIPLES_OF_10.fetch(n / 10 - 1)
          else  "#{words_for((n / 10) * 10, gender)} и #{words_for(n % 10, gender)}"
        end
      end
  end
  
  NumericProxy.send :include, NumberToWords
end
