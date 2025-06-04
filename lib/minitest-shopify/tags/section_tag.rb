class SectionTag < Liquid::Tag
  def initialize(tag_name, section_name, options)
    @section_name = section_name.strip.gsub("'", "")
  end

  def render(context)
    path = File.join(MinitestShopify.configuration.theme_root, "sections", @section_name) + ".liquid"
    file = File.read(path)
    template = Liquid::Template.parse(file, error_mode: :strict)
    template.render!
  end

  Liquid::Environment.default.register_tag('section', self)
end
