module MinitestShopifyThemes::Filters::AssetsFilter
  def asset_url(input)
    File.join("/assets", input)
  end

  def script_tag(input)
    "<script src=\"#{input}\" type=\"text/javascript\"></script>"
  end

  def stylesheet_tag(input)
    "<link href=\"#{input}\" rel=\"stylesheet\" type=\"text/css\" media=\"all\" />"
  end

  Liquid::Environment.default.register_filter(self)
end
