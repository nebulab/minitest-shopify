# Minitest Shopify

Prototype of a minitest test class with capybara assertions capable of rendering sections and snippets of a liquid based Shopify theme.

## Example
```ruby
MinitestShopify.configure do |config|
  config.theme_root = File.join(__dir__, "theme")
end
```

```ruby
require "minitest/autorun"
require "minitest-shopify"

class TestCard < MinitestShopify::LiquidTest
  def test_renders_a_card
    render template: "snippets/card", variables: { "comment" => default_comment }
    assert_text "Hello world!"
    assert_text "John Doe"
  end

  private

  def default_comment
    {
      "id" => 1,
      "created_at" => "2023-07-20T19:31:35Z",
      "content" => "Hello world!",
      "author" => {
        "id" => 1,
        "name" => "John Doe"
      }
    }
  end
end

```
