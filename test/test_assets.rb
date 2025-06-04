require "minitest/autorun"
require "minitest_shopify"

class TestAssets < MinitestShopify::ViewTest
  MinitestShopify.configuration.theme_root = File.join(__dir__, "theme")

  def test_card
    render template: "snippets/alert"
    accept_alert
  end
end
