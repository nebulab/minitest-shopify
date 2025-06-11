require 'money'

module MinitestShopifyThemes::Filters::MoneyFilter
  module TestHelper
    def setup
      super
      Money.locale_backend = :i18n
    end
  end

  class ShopifyMoney < Money
    self.rounding_mode = BigDecimal::ROUND_HALF_UP
    self.locale_backend = :i18n

    def to_liquid
      to_json
    end

    def to_liquid_value
      to_html
    end
  end

  def money(input, currency: "USD")
    ShopifyMoney.new(input, currency)
  end

  Liquid::Environment.default.register_filter(self)
end
