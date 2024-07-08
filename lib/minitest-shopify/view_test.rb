require_relative "./liquid_test"

class MinitestShopify::ViewTest < MinitestShopify::LiquidTest
  include Capybara::DSL

  VIEWS_DIR = Dir.mktmpdir
  Capybara.server = :puma, { Silent: true }
  Capybara.app = Rack::Lint.new Rack::Cascade.new [
    Rack::Files.new(VIEWS_DIR)
  ]
  Minitest.after_run { FileUtils.remove_entry VIEWS_DIR }

  def setup
    Capybara.current_driver = MinitestShopify.configuration.selenium_driver
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
