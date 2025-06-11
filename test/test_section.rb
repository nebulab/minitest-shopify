require "minitest/autorun"
require "minitest_shopify_themes"

class TestSection < MinitestShopifyThemes::LiquidTest
  def test_renders_a_section
    MinitestShopifyThemes.configuration.theme_root = File.join(__dir__, "theme")

    section_settings = {
      settings: {
        title: "Hello world!",
        text: "A long paragraph of text goes here. It should be long enough to wrap to the next line.",
      }
    }
    render template: "sections/text", variables: { section: section_settings }
    assert_selector "h2", text: "Hello world!"
    assert_selector "p", text: "A long paragraph of text goes here. It should be long enough to wrap to the next line."
  end

  def test_renders_a_section_with_image_tag
    MinitestShopifyThemes.configuration.theme_root = File.join(__dir__, "theme")

    section_settings = {
      settings: {
        title: "Hello world!",
        image: "files/image.jpg"
      }
    }
    render template: "sections/image-with-title", variables: { section: section_settings }
    assert_selector "h2", text: "Hello world!"
    assert_element "img", "src": "files/image.jpg"
  end
end
