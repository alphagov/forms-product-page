MarkdownRails.handle :md, :markdown do
  ApplicationMarkdown.new
end

MarkdownRails.handle :markerb do
  ErbMarkdown.new
end
