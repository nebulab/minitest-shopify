require "minitest/autorun"
require "minitest_shopify_themes"

class TestCardView < MinitestShopifyThemes::ViewTest
  MinitestShopifyThemes.configuration.theme_root = File.join(__dir__, "theme")

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
      created_at: "2023-07-20T19:31:35Z",
      content: "Hello world!",
      author: {
        id: 1,
        name: "John Doe"
      }
    }

  end
end
