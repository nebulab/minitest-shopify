class MinitestShopifyThemes::ViewTest < MinitestShopifyThemes::LiquidTest
  include Capybara::DSL

  VIEWS_DIR = Dir.mktmpdir
  Minitest.after_run { FileUtils.remove_entry VIEWS_DIR }
  Capybara.server = :puma, { Silent: true }

  def setup
    Capybara.current_driver = MinitestShopifyThemes.configuration.selenium_driver
    Capybara.app ||= Rack::Lint.new Rack::Cascade.new [
      Rack::Files.new(VIEWS_DIR),
      Rack::URLMap.new("/assets" => Rack::Files.new(MinitestShopifyThemes.configuration.assets_dir)),
    ]
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def render(**)
    super
    host_page do |path|
      visit path
    end
  end

  private

  def host_page
    Tempfile.create(['', '.html'], VIEWS_DIR) do |f|
      f.write(@page)
      f.flush
      yield Pathname.new(f.path).basename
    end
  end
end
