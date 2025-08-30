#!/usr/bin/env ruby
require 'nokogiri'
require 'fileutils'
require 'date'

class WordPressToJekyllMigrator
  def initialize(wp_export_path, jekyll_posts_path)
    @wp_export_path = wp_export_path
    @jekyll_posts_path = jekyll_posts_path
    @migrated_count = 0
  end

  def migrate_all
    puts "Starting migration from #{@wp_export_path} to #{@jekyll_posts_path}"
    
    # Find all WordPress posts in date-structured directories
    structured_posts = Dir.glob(File.join(@wp_export_path, '**/*/index.html')).select do |file|
      # Match pattern: YYYY/MM/DD/slug/index.html
      file.match?(%r{/\d{4}/\d{2}/\d{2}/[^/]+/index\.html$})
    end
    
    # Find root-level WordPress posts with post IDs
    root_posts = Dir.glob(File.join(@wp_export_path, 'index.html?p=*')).select do |file|
      # Skip main index.html without post ID
      !file.end_with?('index.html')
    end
    
    post_files = structured_posts + root_posts
    
    puts "Found #{structured_posts.length} posts in date directories"
    puts "Found #{root_posts.length} posts in root directory"
    puts "Total: #{post_files.length} potential blog posts"
    
    post_files.each do |post_file|
      migrate_post(post_file)
    end
    
    puts "Migration complete! Migrated #{@migrated_count} posts to #{@jekyll_posts_path}"
  end

  private

  def migrate_post(post_file)
    begin
      doc = Nokogiri::HTML(File.open(post_file))
      
      # Extract metadata
      title = extract_title(doc)
      date = extract_date(doc, post_file)
      content = extract_content(doc)
      categories = extract_categories(doc)
      tags = extract_tags(doc)
      
      return unless title && date && content
      
      # Generate Jekyll filename
      slug = extract_slug_from_path(post_file)
      filename = "#{date.strftime('%Y-%m-%d')}-#{slug}.md"
      filepath = File.join(@jekyll_posts_path, filename)
      
      # Generate Jekyll front matter
      front_matter = generate_front_matter(title, date, categories, tags)
      
      # Convert HTML content to Markdown-friendly format
      markdown_content = convert_to_markdown(content)
      
      # Write Jekyll post
      File.open(filepath, 'w') do |f|
        f.write(front_matter)
        f.write("---\n\n")
        f.write(markdown_content)
      end
      
      @migrated_count += 1
      puts "Migrated: #{filename}"
      
    rescue => e
      puts "Error migrating #{post_file}: #{e.message}"
    end
  end

  def extract_title(doc)
    title_element = doc.css('h1.entry-title').first
    title_element ? title_element.text.strip : nil
  end

  def extract_date(doc, post_file)
    # Try to extract from datetime attribute first
    time_element = doc.css('time.entry-date').first
    if time_element && time_element['datetime']
      return DateTime.parse(time_element['datetime'])
    end
    
    # Fall back to extracting from file path
    if match = post_file.match(%r{/(\d{4})/(\d{2})/(\d{2})/})
      year, month, day = match[1], match[2], match[3]
      return Date.new(year.to_i, month.to_i, day.to_i)
    end
    
    nil
  end

  def extract_content(doc)
    content_element = doc.css('div.entry-content').first
    return nil unless content_element
    
    # Clean up the content - remove WordPress-specific elements
    content_element.css('script').remove
    content_element
  end

  def extract_categories(doc)
    categories = []
    doc.css('span.categories-links a').each do |link|
      categories << link.text.strip
    end
    categories
  end

  def extract_tags(doc)
    tags = []
    doc.css('span.tags-links a').each do |link|
      tags << link.text.strip
    end
    tags
  end

  def extract_slug_from_path(post_file)
    if post_file.include?('index.html?p=')
      # Extract post ID from root-level files: index.html?p=1234
      post_id = post_file.match(/p=(\d+)/)[1]
      "post-#{post_id}"
    else
      # Extract slug from path: /YYYY/MM/DD/slug/index.html
      parts = post_file.split('/')
      slug = parts[-2] # Second to last part is the slug
      slug.gsub(/[^a-zA-Z0-9\-_]/, '-').squeeze('-')
    end
  end

  def generate_front_matter(title, date, categories, tags)
    front_matter = "---\n"
    front_matter += "layout: post\n"
    front_matter += "title: \"#{title.gsub('"', '\\"')}\"\n"
    front_matter += "date: #{date.strftime('%Y-%m-%d %H:%M:%S %z')}\n"
    
    if categories.any?
      front_matter += "categories: [#{categories.map { |c| "\"#{c}\"" }.join(', ')}]\n"
    end
    
    if tags.any?
      front_matter += "tags: [#{tags.map { |t| "\"#{t}\"" }.join(', ')}]\n"
    end
    
    front_matter
  end

  def convert_to_markdown(content_element)
    # Basic HTML to Markdown conversion
    html = content_element.to_html
    
    # Convert basic HTML tags to Markdown
    html = html.gsub(/<p>(.*?)<\/p>/m, "\\1\n\n")
    html = html.gsub(/<br\s*\/?>/i, "\n")
    html = html.gsub(/<strong>(.*?)<\/strong>/i, "**\\1**")
    html = html.gsub(/<b>(.*?)<\/b>/i, "**\\1**")
    html = html.gsub(/<em>(.*?)<\/em>/i, "*\\1*")
    html = html.gsub(/<i>(.*?)<\/i>/i, "*\\1*")
    html = html.gsub(/<u>(.*?)<\/u>/i, "*\\1*")
    
    # Convert links
    html = html.gsub(/<a\s+href=["\']([^"\']*)["\'][^>]*>(.*?)<\/a>/i, "[\\2](\\1)")
    
    # Convert headers
    (1..6).each do |level|
      html = html.gsub(/<h#{level}[^>]*>(.*?)<\/h#{level}>/i, "#{'#' * level} \\1\n\n")
    end
    
    # Convert pre/code blocks
    html = html.gsub(/<pre[^>]*>(.*?)<\/pre>/m) do
      content = $1.strip
      "```\n#{content}\n```\n\n"
    end
    
    html = html.gsub(/<code[^>]*>(.*?)<\/code>/i, "`\\1`")
    
    # Clean up remaining HTML tags and entities
    html = html.gsub(/<[^>]+>/, '')
    html = html.gsub(/&nbsp;/, ' ')
    html = html.gsub(/&amp;/, '&')
    html = html.gsub(/&lt;/, '<')
    html = html.gsub(/&gt;/, '>')
    html = html.gsub(/&quot;/, '"')
    html = html.gsub(/&#8217;/, "'")
    html = html.gsub(/&#8220;/, '"')
    html = html.gsub(/&#8221;/, '"')
    html = html.gsub(/&#8211;/, '–')
    html = html.gsub(/&#8212;/, '—')
    html = html.gsub(/&#8230;/, '…')
    html = html.gsub(/&hellip;/, '…')
    html = html.gsub(/&ldquo;/, '"')
    html = html.gsub(/&rdquo;/, '"')
    html = html.gsub(/&lsquo;/, "'")
    html = html.gsub(/&rsquo;/, "'")
    
    # Clean up excessive whitespace
    html = html.gsub(/\n{3,}/, "\n\n")
    html.strip
  end
end

# Run the migration
if __FILE__ == $0
  wp_path = '/Users/judytuna/src/judytuna-dot-com/judytuna.com'
  jekyll_path = '/Users/judytuna/src/judytuna-dot-com/judytuna-jekyll/_posts'
  
  unless Dir.exist?(wp_path)
    puts "WordPress export directory not found: #{wp_path}"
    exit 1
  end
  
  unless Dir.exist?(jekyll_path)
    puts "Jekyll posts directory not found: #{jekyll_path}"
    exit 1
  end
  
  migrator = WordPressToJekyllMigrator.new(wp_path, jekyll_path)
  migrator.migrate_all
end