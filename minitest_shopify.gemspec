# frozen_string_literal: true


Gem::Specification.new do |spec|
  spec.name = 'minitest_shopify'
  spec.version = '0.1.0'
  spec.authors = ['Nick Belzer']
  spec.email = 'nickbelzer@nebulab.com'

  spec.summary = 'A minitest plugin for testing Shopify Liquid themes'
  spec.homepage = "https://github.com/nebulab/minitest-shopify?tab=readme-ov-file#readme"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["bug_tracker_uri"] = "https://github.com/nebulab/minitest-shopify/issues"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nebulab/minitest-shopify"
  spec.metadata["changelog_uri"] = "https://github.com/nebulab/minitest-shopify/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('capybara')
  spec.add_dependency('selenium-webdriver')
  spec.add_dependency('puma')
  spec.add_dependency('rackup')
  spec.add_dependency('minitest')
  spec.add_dependency('liquid')
  spec.add_dependency('bigdecimal')
  spec.add_dependency('zeitwerk')
end
