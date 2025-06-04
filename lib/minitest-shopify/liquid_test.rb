require "minitest/autorun"
require "capybara/minitest"
require "liquid"
require 'json'
require 'loofah'

require_relative "tags/schema_tag"
require_relative "tags/section_tag"
require_relative "filters/image_filter"
require_relative "filters/assets_filter"
require_relative "filters/money_filter"
require_relative "filters/translations_filter"

class MinitestShopify::LiquidTest < Minitest::Test
  include Capybara::Minitest::Assertions

  def setup
    Liquid::Environment.default.error_mode = :strict

    Money.locale_backend = :i18n

    require 'i18n'

    Dir["#{MinitestShopify.configuration.theme_root}/locales/*.json"].each do |file|
      next if file.end_with?('.schema.json')

      command = %{node -pe "JSON.stringify(eval('data='+require('fs').readFileSync(0, 'utf8')))"}
      # Use Node.js to parse JSON, as it handles comments in JSON files
      # and is more lenient than Ruby's JSON parser.
      r, w = IO.pipe
      pid = Process.spawn(command, in: file, out: w, err: :close, close_others: true)
      w.close
      Process.wait(pid)
      raise "Failed to parse JSON from #{file}" unless $?.success?
      contents = r.read
      r.close
      require 'json'
      data = JSON.parse!(contents) rescue binding.irb
      locale = File.basename(file, '.json').chomp(".default")
      I18n.backend.store_translations(locale.to_sym, data)
      if file.end_with?('.default.json')
        @default_locale = locale.to_sym
      end
    end

    I18n.locale = @default_locale || I18n.default_locale
  end

  def render(template:, variables: {})
    @page = render_liquid(template:, variables:)
    unless MinitestShopify.configuration.layout_file.nil?
      @page = render_liquid(
        template: MinitestShopify.configuration.layout_file,
        variables: variables.merge({ content_for_layout: @page })
      )
    end
  end

  # Helper to enable Capybara assertions on the rendered template.
  def page
    Capybara.string(@page)
  end

  attr_reader :html, :doc

  def render_liquid(template:, variables:)
    file = File.read(File.join(MinitestShopify.configuration.theme_root, template) + ".liquid")
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
