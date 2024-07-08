module MinitestShopify
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end

  require "minitest-shopify/configuration"
  require "minitest-shopify/liquid_test"
  require "minitest-shopify/view_test"
end
