module TranslationsFilter
  def t(key, variables = {})
    I18n.t(key).gsub(/{{\s*([a-zA-Z0-9_]+)\s*}}/) do |match|
      var_name = $1
      if variables.key?(var_name)
        variables[var_name].to_s
      else
        match # Return the original match if variable not found
      end
    end
  end

  Liquid::Environment.default.register_filter(self)
end
