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

## Installation
This is an experiment for the time being, if you want to try it out for yourself you can add the following definition to your gemfile:

```ruby
gem "minitest-shopify", git: "https://github.com/nebulab/minitest-shopify.git", branch: "main"
```
