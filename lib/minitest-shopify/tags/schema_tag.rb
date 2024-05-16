class SchemaTag < Liquid::Block
  def render(context)
    # The schema tag renders nothing.
    nil
  end
end
Liquid::Template.register_tag('schema', SchemaTag)
