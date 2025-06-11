class MinitestShopifyThemes::Tags::SectionTag < Liquid::Tag
  def initialize(tag_name, section_name, options)
    @section_name = section_name.strip.gsub("'", "")
  end

  def render(context)
    file = MinitestShopifyThemes.configuration.theme_root.join("sections", @section_name + ".liquid").read
    template = Liquid::Template.parse(file, error_mode: :strict)
    template.render!
  end

  Liquid::Environment.default.register_tag('section', self)
end
