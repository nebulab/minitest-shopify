module ImageFilter
  def image_url(input, width = nil, height = nil)
    input
  end

  def image_tag(input, args)
    attributes = args.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")
    "<img src=\"#{input}\" #{attributes} />"
  end
end
Liquid::Template.register_filter(ImageFilter)
