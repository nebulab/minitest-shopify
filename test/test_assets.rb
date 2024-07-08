require "minitest/autorun"
require "minitest-shopify"

class TestAssets < MinitestShopify::ViewTest
  MinitestShopify.configuration.theme_root = File.join(__dir__, "theme")

  def test_card
    render template: "snippets/alert", variables: {}
    accept_alert
  end
end
