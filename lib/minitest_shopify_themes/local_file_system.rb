require "liquid"

module MinitestShopifyThemes
  # This is an override for the LocalFileSystem that is part of Liquid
  # gem.  However, out of the box it does not support snippets with a
  # '-' in the name.  This override exists to allow for that and achieve
  # parity with Shopify.  We might want to push this upstream to the
  # Liquid gem.
  class LocalFileSystem < Liquid::LocalFileSystem
    def full_path(template_path)
      raise ::Liquid::FileSystemError, "Illegal template name '#{template_path}'" unless %r{\A[^./][a-zA-Z0-9_\-/]+\z}.match?(template_path)

      full_path = if template_path.include?('/')
        File.join(root, File.dirname(template_path), @pattern % File.basename(template_path))
      else
        File.join(root, @pattern % template_path)
      end

      raise ::Liquid::FileSystemError, "Illegal template path '#{File.expand_path(full_path)}'" unless File.expand_path(full_path).start_with?(File.expand_path(root))

      full_path
    end
  end
end
