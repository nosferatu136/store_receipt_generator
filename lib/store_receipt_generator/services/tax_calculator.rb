module StoreReceiptGenerator
  module Services
    module Categories
      EXEMPT =  { key_words: %w[book chocolate pills], tax_rate: 0.0 }
      IMPORT =  { key_words: %w[imported], tax_rate: 0.05 }
      SALES =   { key_words: [], tax_rate: 0.10 }
    end

    class TaxCalculator

      attr_reader :item_price, :item_description

      def calculate
        [tax_rate, tax_amount]
      end

      private

      def initialize(item_price, item_description)
        @item_price = item_price
        @item_description = item_description
      end

      def tax_amount
        return 0.0 unless tax_rate > 0.0
        initial_amount = (item_price * tax_rate).round(2)
        DecimalRounder.round(initial_amount)
      end

      def tax_rate
        @tax_rate ||= begin
          _tax_rate = 0.0
          _tax_rate = Categories::SALES[:tax_rate] if applies_sales_tax?
          _tax_rate += Categories::IMPORT[:tax_rate] if applies_import_tax?
          _tax_rate.round(2)
        end
      end

      def applies_sales_tax?
        Categories::EXEMPT[:key_words].none? { |word| item_description.include?(word) }
      end

      def applies_import_tax?
        Categories::IMPORT[:key_words].any? { |word| item_description.include?(word) }
      end

      class DecimalRounder

        attr_reader :int_part, :decimal_part

        def self.round(initial_amount)
          new(initial_amount).round
        end

        def initialize(initial_amount)
          @int_part, @decimal_part = initial_amount.to_s.split('.').map(&:to_i)
        end
        
        def round
          cents_to_5 = decimal_part % 5
          return "#{int_part}.#{decimal_part}".to_f if decimal_part < 10 || cents_to_5 == 0
          @decimal_part += 5 - cents_to_5
          if decimal_part == 100
            @int_part += 1
            @decimal_part = 0
          end
          "#{int_part}.#{decimal_part}".to_f
        end
      end
    end
  end
end