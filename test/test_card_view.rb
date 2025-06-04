require "minitest/autorun"
require "minitest_shopify"

class TestCardView < MinitestShopify::ViewTest
  MinitestShopify.configuration.theme_root = File.join(__dir__, "theme")

  def test_javascript_enabled_card
    render template: "snippets/js-card", variables: { comment: default_comment }

    within "#comment-1" do
      assert_text "Javascript is enabled"
      assert_no_text "Hello World"
    end
  end

  private

  def default_comment
    {
      id: 1,
      content: "Hello world!",
    }
  end
end
