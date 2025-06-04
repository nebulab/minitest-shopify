require "minitest/autorun"
require "minitest_shopify"

class TestCard < MinitestShopify::LiquidTest
  MinitestShopify.configuration.theme_root = File.join(__dir__, "theme")

  def test_renders_a_card
    render template: "snippets/card", variables: { comment: default_comment }
    assert_text "Hello world!"
    assert_text "John Doe"
  end

  private

  def default_comment
    {
      id: 1,
      created_at: "2023-07-20T19:31:35Z",
      content: "Hello world!",
      author: {
        id: 1,
        name: "John Doe"
      }
    }
  end
end
