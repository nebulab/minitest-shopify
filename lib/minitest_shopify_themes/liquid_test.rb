require "minitest/autorun"
require "capybara/minitest"
require "liquid"
require "loofah"

MinitestShopifyThemes.loader.eager_load_namespace(MinitestShopifyThemes::Tags)
MinitestShopifyThemes.loader.eager_load_namespace(MinitestShopifyThemes::Filters)

class MinitestShopifyThemes::LiquidTest < Minitest::Test
  include Capybara::Minitest::Assertions
  include MinitestShopifyThemes::Filters::TranslationsFilter::TestHelper
  include MinitestShopifyThemes::Filters::MoneyFilter::TestHelper

  def render(template:, variables: {})
    @page = render_liquid(template:, variables:)

    if MinitestShopifyThemes.configuration.layout_file
      @page = render_liquid(
        template: MinitestShopifyThemes.configuration.layout_file,
        variables: variables.merge({ content_for_layout: @page })
      )
    end
  end

  # Helper to enable Capybara assertions on the rendered template.
  def page
    Capybara.string(@page)
  end

  def render_liquid(template:, variables:)
    file = File.read(File.join(MinitestShopifyThemes.configuration.theme_root, template) + ".liquid")
    template = Liquid::Template.parse(file, error_mode: :strict)
    @output = template.render!(deep_stringify_keys(variables), {strict_variables: true, strict_filters: true})
  end

  def text
    html&.to_text(encode_special_chars: false).gsub(/\s+/, ' ').strip
  end

  def html
    Loofah.html5_fragment(@output)
  end

  def deep_stringify_keys(hash)
    # Liquid expects string keys for variables, but Rails convention is to use symbols.
    # This method recursively converts all keys to strings so either convention can be used.
    hash.each_with_object({}) do |(key, value), acc|
      acc[key.to_s] = value.is_a?(Hash) ? deep_stringify_keys(value) : value
    end
  end
end
