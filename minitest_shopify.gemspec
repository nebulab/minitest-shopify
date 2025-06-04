Gem::Specification.new do |s|
  s.name = 'minitest_shopify'
  s.version = '0.1.0'
  s.summary = 'A minitest plugin for testing Shopify Liquid themes'
  s.authors = ['Nick Belzer']
  s.email = 'nickbelzer@nebulab.com'
  s.files = Dir['lib/**/*.rb']

  s.add_dependency('capybara')
  s.add_dependency('selenium-webdriver')
  s.add_dependency('puma')
  s.add_dependency('rackup')
  s.add_dependency('minitest')
  s.add_dependency('liquid')
  s.add_dependency('bigdecimal')
  s.add_dependency('zeitwerk')
end
