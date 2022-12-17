module StoreReceiptGenerator
  module Models
    class Item
      attr_reader :quantity, :description, :price, :tax_rate, :tax_amount

      def total_price
        (quantity * (price + tax_amount)).round(2)
      end

      private

      def initialize(item_hash)
        @quantity = item_hash[:quantity]
        @description = item_hash[:description]
        @price = item_hash[:price]
        @tax_rate = item_hash[:tax_rate]
        @tax_amount = item_hash[:tax_amount]
      end
    end
  end
end
