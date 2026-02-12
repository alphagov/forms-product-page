require "govuk_markdown"
require "redcarpet"

class ApplicationMarkdown < GovukMarkdown::Renderer
  # Transform straight quotes to curly quotes
  include Redcarpet::Render::SmartyPants

  delegate \
    :helpers,
    :render,
    to: :base_controller

  def initialize(options = {})
    super({}, options)
  end

  def enable
    [
      :fenced_code_blocks, # Allow non-indented code blocks
      :no_intra_emphasis, # Don't treat underscores in the middle of words as emphasis
      :with_toc_data, # Add IDs to headings for table of contents
    ]
  end

  def renderer
    ::Redcarpet::Markdown.new(self.class.new(**features), **features)
  end

  def preprocess(content)
    _frontmatter, body = extract_frontmatter(content)
    rendered_body = render inline: body, handler: :erb
    # Rails can annotate inline templates with HTML comments. Strip them before
    # markdown conversion so they do not appear as visible text.
    rendered_body.gsub(/<!--(.*?)-->/m, "").strip
  end

protected

  def base_controller
    ::ApplicationController
  end

private

  def extract_frontmatter(content)
    frontmatter_match = content.match(/\A---\s*\r?\n(?<yaml>.*?)\r?\n---\s*(?:\r?\n|$)/m)
    return [nil, content] unless frontmatter_match

    [frontmatter_match[:yaml], content.delete_prefix(frontmatter_match[0])]
  end

  def features
    Array(enable).index_with { |_feature| true }
  end
end
