# Minitest Shopify

Prototype of a minitest test class with capybara assertions capable of rendering sections and snippets of a liquid based Shopify theme.

## Example
```ruby
MinitestShopify.configure do |config|
  config.theme_root = File.join(__dir__, "theme")
  config.selenium_driver = :selenium_chrome_headless
  config.layout_file = "layout/theme"
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

You can also use selenium to run tests that involve JavaScript or assets:

```ruby
require "minitest/autorun"
require "minitest-shopify"

class TestCardView < MinitestShopify::ViewTest
  def test_javascript_enabled_card
    render template: "snippets/js-card", variables: { "comment" => default_comment }
    within "#comment-1" do
      assert_text "Javascript is enabled"
      assert_no_text "Hello World"
    end
  end

  private

  def default_comment
    {
      "id" => 1,
      "content" => "Hello world!",
    }
  end
end
```

## Installation
This is an experiment for the time being, if you want to try it out for yourself you can add the following definition to your gemfile:

```ruby
gem "minitest-shopify", git: "https://github.com/nebulab/minitest-shopify.git", branch: "main"
```
