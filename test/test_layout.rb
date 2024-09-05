require "minitest/autorun"
require "minitest-shopify"

class TestLayout < MinitestShopify::LiquidTest
  MinitestShopify.configuration.theme_root = File.join(__dir__, "theme")
  MinitestShopify.configuration.layout_file = File.join("layout/theme")

  def test_renders_snippet_with_layout
    render template: "snippets/card", variables: { comment: default_comment }
    assert_text "Hello layout!"
    assert_selector "body.custom-layout"
    assert_selector "section"
  end

  private

  def default_comment
    {
      id: 1,
      content: "Hello layout!",
    }
  end
end
