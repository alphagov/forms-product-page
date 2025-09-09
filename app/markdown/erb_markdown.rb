class ErbMarkdown < ApplicationMarkdown
  def preprocess(html)
    processed_html = render inline: html, handler: :erb
    # strip out comments as the markdown renderer converts -- to – causing them to be rendered as text on the page
    processed_html.gsub(/<!--(.*?)-->/, "").strip
  end
end
