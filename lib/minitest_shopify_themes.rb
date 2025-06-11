require_relative "minitest_shopify_themes/version"
require "zeitwerk"

module MinitestShopifyThemes
  def self.loader
    @loader ||= Zeitwerk::Loader.for_gem
  end

  loader.setup
  # loader.eager_load # optionally

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
