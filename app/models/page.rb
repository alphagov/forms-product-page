require "yaml"

class Page
  Entry = Struct.new(
    :section,
    :slug,
    :route_slug,
    :template,
    :title,
    :page_title,
    :page_description,
    :navigation_order,
    keyword_init: true,
  )

  FILE_PATTERN = /\.(?:html\.)?(?:markerb|md|erb)\z/

  class << self
    def for(section)
      @collections ||= {}
      @collections[section.to_s] ||= new(section.to_s)
    end

    def reset_cache!
      @collections = nil
    end
  end

  attr_reader :section

  def initialize(section)
    @section = section
  end

  def all
    @all ||= load_pages.freeze
  end

  def find_by_slug(slug)
    all.find { |page| page.slug == slug.to_s.tr("-", "_") }
  end

  def navigation_pages(order: [])
    order_index = order.each_with_index.to_h

    all.sort_by do |page|
      [
        page.navigation_order || order_index.fetch(page.slug, order.length),
        page.slug,
      ]
    end
  end

private

  def views_directory
    Rails.root.join("app/views/pages", section)
  end

  def template_prefix
    "pages/#{section}"
  end

  def load_pages
    Dir.glob(views_directory.join("*")).sort.filter_map do |path|
      next unless File.file?(path)

      filename = File.basename(path)
      next unless filename.match?(FILE_PATTERN)

      slug = filename.sub(FILE_PATTERN, "")
      content = File.read(path)
      metadata = extract_metadata(content, slug)

      Entry.new(
        section: section,
        slug: slug,
        route_slug: slug.tr("_", "-"),
        template: "#{template_prefix}/#{slug}",
        title: metadata[:title],
        page_title: metadata[:page_title],
        page_description: metadata[:page_description],
        navigation_order: metadata[:navigation_order],
      )
    end
  end

  def extract_metadata(content, slug)
    frontmatter, body = extract_frontmatter(content)
    frontmatter_data = parse_frontmatter(frontmatter)

    title = extract_heading(body) || slug.humanize
    page_title = frontmatter_data["page_title"].presence || frontmatter_data["title"].presence || title
    page_description = frontmatter_data["page_description"].presence || frontmatter_data["description"].presence

    {
      title: title,
      page_title: page_title,
      page_description: page_description,
      navigation_order: parse_navigation_order(frontmatter_data["navigation_order"]),
    }
  end

  def parse_navigation_order(value)
    return if value.blank?

    Integer(value)
  rescue ArgumentError, TypeError
    nil
  end

  def extract_heading(content)
    heading = content.each_line.find { |line| line.match?(/^\s*#\s+/) }
    heading&.sub(/^\s*#\s+/, "")&.strip.presence
  end

  def extract_frontmatter(content)
    frontmatter_match = content.match(/\A---\s*\r?\n(?<yaml>.*?)\r?\n---\s*(?:\r?\n|$)/m)
    return [nil, content] unless frontmatter_match

    [frontmatter_match[:yaml], content.delete_prefix(frontmatter_match[0])]
  end

  def parse_frontmatter(frontmatter)
    return {} if frontmatter.blank?

    parsed = YAML.safe_load(frontmatter, aliases: false)
    return {} unless parsed.is_a?(Hash)

    parsed.transform_keys(&:to_s)
  rescue Psych::Exception
    {}
  end
end
