class ErbMarkdown < ApplicationMarkdown
  def preprocess(html)
    processed_html = render inline: html, handler: :erb
    processed_html.sub(/^<!-- BEGIN inline template -->/, "").sub(/<!-- END inline template -->$/, "").strip
  end
end
