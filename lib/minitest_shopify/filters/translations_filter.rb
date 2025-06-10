require 'i18n'

module MinitestShopify::Filters::TranslationsFilter
  module TestHelper
    def setup
      super

      Dir["#{MinitestShopify.configuration.theme_root}/locales/*.json"].each do |file|
        next if file.end_with?('.schema.json')

        command = %{node -pe "JSON.stringify(eval('data='+require('fs').readFileSync(0, 'utf8')))"}
        # Use Node.js to parse JSON, as it handles comments in JSON files
        # and is more lenient than Ruby's JSON parser.
        r, w = IO.pipe
        pid = Process.spawn(command, in: file, out: w, err: :close, close_others: true)
        w.close
        Process.wait(pid)
        raise "Failed to parse JSON from #{file}" unless $?.success?
        contents = r.read
        r.close
        require 'json'
        data = JSON.parse!(contents) rescue binding.irb
        locale = File.basename(file, '.json').chomp(".default")
        I18n.backend.store_translations(locale.to_sym, data)
        if file.end_with?('.default.json')
          @default_locale = locale.to_sym
        end
      end

      I18n.locale = @default_locale || I18n.default_locale
    end
  end

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
