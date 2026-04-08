require "govuk_markdown"

class ApplicationMarkdown < MarkdownRails::Renderer::Rails
  # Transform straight quotes to curly quotes
  include Redcarpet::Render::SmartyPants

  # Use GOV.UK Design System markup and classes
  include GovukMarkdown::Renderer::Mixin

  def enable
    [
      :fenced_code_blocks, # Allow non-indented code blocks
      :no_intra_emphasis, # Don't treat underscores in the middle of words as emphasis
      :with_toc_data, # Add IDs to headings for table of contents
    ]
  end
end
