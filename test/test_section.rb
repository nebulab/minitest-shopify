require "minitest/autorun"
require "minitest-shopify"

class TestSection < MinitestShopify::LiquidTest
  def test_renders_a_section
    MinitestShopify.configuration.theme_root = File.join(__dir__, "theme")

    section_settings = {
      "settings" => {
        "title" => "Hello world!",
        "text" => "A long paragraph of text goes here. It should be long enough to wrap to the next line.",
      }
    }
    render template: "sections/text", variables: { "section" => section_settings }
    assert_selector "h2", text: "Hello world!"
    assert_selector "p", text: "A long paragraph of text goes here. It should be long enough to wrap to the next line."
  end
end
