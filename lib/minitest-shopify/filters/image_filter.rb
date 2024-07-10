module ImageFilter
  def image_url(input, width = nil, height = nil)
    input
  end

  def image_tag(input)
    "<img src=\"#{input}\" />"
  end
end
Liquid::Template.register_filter(ImageFilter)
