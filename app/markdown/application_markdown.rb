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

protected

  def base_controller
    ::ApplicationController
  end

private

  def features
    Array(enable).index_with { |_feature| true }
  end
end
