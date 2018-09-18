module Jekyll
  module Tags
    class ExampleBlock < Liquid::Block
      include Liquid::StandardFilters

      # The regular expression syntax2 checker. Start with the language specifier.
      # Follow that by zero or more space separated options that take one of three
      # forms: name, name=value, or name="<quoted list>"
      #
      # <quoted list> is a space-separated list of numbers
      SYNTAX2 = /^([a-zA-Z0-9.+#-]+)((\s+\w+(=((\w|[0-9_-])+|"([0-9]+\s)*[0-9]+"))?)*)$/

      def initialize(tag_name, markup, tokens)
        super
        if markup.strip =~ SYNTAX2
          @lang = $1.downcase
          @options = {}
          if defined?($2) && $2 != ''
            # Split along 3 possible forms -- key="<quoted list>", key=value, or key
            $2.scan(/(?:\w+(?:=(?:(?:\w|[0-9_-])+|"[^"]*")?)?)/) do |opt|
              key, value = opt.split('=')
              # If a quoted list, convert to array
              if value && value.include?("\"")
                  value.gsub!(/"/, "")
                  value = value.split
              end
              @options[key.to_sym] = value || true
            end
          end
          @options[:linenos] = false
        else
          raise Syntax2Error.new <<-eos
Syntax2 Error in tag 'example' while parsing the following markup:

  #{markup}

Valid syntax2: example <lang> [id=foo]
eos
        end
      end

      def render(context)
        prefix = context["highlighter_prefix"] || ""
        suffix = context["highlighter_suffix"] || ""
        code = super.to_s.strip

        output = case context.registers[:site].highlighter

        when 'rouge'
          render_rouge(code)
        end

        rendered_output = example(code) + add_code_tag(output)
        prefix + rendered_output + suffix
      end


      def render_rouge(code)
        require 'rouge'
        formatter = Rouge::Formatters::HTML.new(line_numbers: @options[:linenos], wrap: false)
        lexer = Rouge::Lexer.find_fancy(@lang, code) || Rouge::Lexers::PlainText
        code = formatter.format(lexer.lex(code))
        "<div class=\"highlight\"><pre>#{code}</pre></div> <div class=\"c-a c-p-sm c-text-xs c-m-bottom-xl c-bg-gray-2\" id=\"highlight-toggle\">HTML <i class=\"fas fa-caret-down\"></i></div>"
      end

      def add_code_tag(code)
        # Add nested <code> tags to code blocks
        code = code.sub(/<pre>\n*/,'<pre><code class="language-' + @lang.to_s.gsub("+", "-") + '" data-lang="' + @lang.to_s + '">')
        code = code.sub(/\n*<\/pre>/,"</code></pre>")
        code.strip
      end

    end
  end
end

Liquid::Template.register_tag('highlight', Jekyll::Tags::HighlightBlock)