class SchemaTag < Liquid::Block
  def render(context)
    # The schema tag renders nothing.
    nil
  end
end
Liquid::Environment.default.register_tag('schema', SchemaTag)
