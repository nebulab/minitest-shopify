require_relative "file_system"

class MinitestShopify::Configuration
  attr_reader :theme_root
  attr_accessor :selenium_driver, :layout_file

  def initialize
    @theme_root = "./theme"
    @selenium_driver = :selenium_chrome_headless
    @layout_file = nil
  end

  def theme_root=(value)
    @theme_root = value

    # We set up a file system to be able to render snippets from within
    # the templates we provide to the render method.  The render method is
    # only used to render a snippet or app block, however, we cannot
    # emulate the render of an app block, so its okay to default to
    # snippets.
    Liquid::Template.file_system = MinitestShopify::LocalFileSystem.new(@theme_root, "snippets/%s.liquid")
  end

  def assets_dir
    File.join(@theme_root, "assets")
  end
end
