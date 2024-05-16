require "minitest/autorun"
require "capybara/minitest"
require "liquid"
require_relative "tags/schema_tag"

class MinitestShopify::LiquidTest < Minitest::Test
  include Capybara::Minitest::Assertions

  def render(template:, variables:)
    file = File.read(File.join(MinitestShopify.configuration.theme_root, template) + ".liquid")
    template = Liquid::Template.parse(file, error_mode: :strict)
    @page = template.render!(**variables)
  end

  # Helper to enable Capybara assertions on the rendered template.
  def page
    Capybara.string(@page)
  end
end
