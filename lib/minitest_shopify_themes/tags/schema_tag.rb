class MinitestShopifyThemes::Tags::SchemaTag < Liquid::Block
  def render(context)
    # The schema tag renders nothing.
    nil
  end

  Liquid::Environment.default.register_tag('schema', self)
end
