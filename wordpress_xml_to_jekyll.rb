#!/usr/bin/env ruby
require 'nokogiri'
require 'fileutils'
require 'date'
require 'yaml'

class WordPressXMLToJekyll
  def initialize(xml_file_path, jekyll_posts_path)
    @xml_file_path = xml_file_path
    @jekyll_posts_path = jekyll_posts_path
    @migrated_count = 0
    @skipped_count = 0
    @existing_files = {}
    
    # Build index of existing files
    build_existing_files_index
  end

  def migrate_all
    puts "Starting WordPress XML migration from #{@xml_file_path}"
    puts "Target directory: #{@jekyll_posts_path}"
    puts "Found #{@existing_files.keys.length} existing Jekyll posts"
    
    # Parse the XML
    doc = Nokogiri::XML(File.open(@xml_file_path))
    
    # Extract all items (posts, pages, etc.)
    items = doc.xpath('//item')
    puts "Found #{items.length} items in WordPress export"
    
    items.each do |item|
      process_item(item)
    end
    
    puts "\nMigration complete!"
    puts "Migrated: #{@migrated_count} new posts"
    puts "Skipped: #{@skipped_count} items (pages, drafts, or duplicates)"
    puts "Total Jekyll posts: #{Dir.glob(File.join(@jekyll_posts_path, '*.md')).length}"
  end

  private

  def build_existing_files_index
    Dir.glob(File.join(@jekyll_posts_path, '*.md')).each do |file|
      begin
        content = File.read(file)
        if content.match(/^---\s*\n(.*?\n?)^---\s*\n/m)
          front_matter = YAML.load($1)
          title = front_matter['title']
          date = front_matter['date']
          
          if title && date
            # Create keys for duplicate detection
            date_str = date.is_a?(String) ? date : date.strftime('%Y-%m-%d')
            key = "#{date_str}-#{normalize_title(title)}"
            @existing_files[key] = file
          end
        end
      rescue => e
        puts "Warning: Could not process existing file #{file}: #{e.message}"
      end
    end
  end

  def process_item(item)
    begin
      # Extract basic info
      title = extract_text(item, 'title')
      post_type = extract_text(item, 'wp:post_type')
      status = extract_text(item, 'wp:status')
      pub_date = extract_text(item, 'pubDate')
      content = extract_text(item, 'content:encoded')
      excerpt = extract_text(item, 'excerpt:encoded')
      
      # Only process published posts (skip pages, drafts, etc.)
      unless post_type == 'post' && status == 'publish'
        @skipped_count += 1
        return
      end
      
      # Skip if no content
      if content.nil? || content.strip.empty?
        puts "Skipping post with missing content"
        @skipped_count += 1
        return
      end
      
      # Parse date first
      begin
        date = DateTime.parse(pub_date)
      rescue => e
        puts "Error parsing date: #{e.message}"
        @skipped_count += 1
        return
      end
      
      # Generate title if missing
      if title.nil? || title.strip.empty?
        # Use first few words of content as title, or date-based title
        first_words = content.gsub(/<[^>]+>/, '').strip.split(/\s+/)[0..5].join(' ')
        if first_words.length > 10
          title = first_words.gsub(/[^\w\s]/, '').strip
        else
          title = "Post from #{date.strftime('%B %d, %Y')}"
        end
        puts "Generated title for post: #{title}"
      end
      
      # Check if we already have this post
      date_str = date.strftime('%Y-%m-%d')
      check_key = "#{date_str}-#{normalize_title(title)}"
      
      if @existing_files[check_key]
        puts "Skipping duplicate: #{title} (#{date_str})"
        @skipped_count += 1
        return
      end
      
      # Extract categories and tags
      categories = extract_categories(item)
      tags = extract_tags(item)
      
      # Generate Jekyll filename
      slug = slugify(title)
      filename = "#{date.strftime('%Y-%m-%d')}-#{slug}.md"
      filepath = File.join(@jekyll_posts_path, filename)
      
      # Avoid filename conflicts
      counter = 1
      while File.exist?(filepath)
        filename = "#{date.strftime('%Y-%m-%d')}-#{slug}-#{counter}.md"
        filepath = File.join(@jekyll_posts_path, filename)
        counter += 1
      end
      
      # Convert HTML content to Markdown
      markdown_content = html_to_markdown(content)
      
      # Generate Jekyll front matter
      front_matter = generate_front_matter(title, date, categories, tags, excerpt)
      
      # Write Jekyll post
      File.open(filepath, 'w') do |f|
        f.write(front_matter)
        f.write("---\n\n")
        f.write(markdown_content)
      end
      
      @migrated_count += 1
      puts "Migrated: #{filename}"
      
    rescue => e
      puts "Error processing item: #{e.message}"
      @skipped_count += 1
    end
  end

  def extract_text(item, xpath)
    element = item.at_xpath(xpath)
    element ? element.text.strip : nil
  end

  def extract_categories(item)
    categories = []
    item.xpath('.//category[@domain="category"]').each do |cat|
      categories << cat.text.strip
    end
    categories
  end

  def extract_tags(item)
    tags = []
    item.xpath('.//category[@domain="post_tag"]').each do |tag|
      tags << tag.text.strip
    end
    tags
  end

  def normalize_title(title)
    title.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s+/, ' ').strip
  end

  def slugify(title)
    title.downcase
         .gsub(/[^a-z0-9\s\-_]/, '')  # Remove special chars except spaces, hyphens, underscores
         .gsub(/\s+/, '-')             # Replace spaces with hyphens
         .gsub(/-+/, '-')              # Collapse multiple hyphens
         .gsub(/^-|-$/, '')            # Remove leading/trailing hyphens
         .slice(0, 50)                 # Limit length
  end

  def html_to_markdown(html_content)
    return '' if html_content.nil? || html_content.strip.empty?
    
    # Basic HTML to Markdown conversion
    content = html_content.dup
    
    # Convert paragraphs
    content = content.gsub(/<p[^>]*>(.*?)<\/p>/mi, "\\1\n\n")
    
    # Convert headers
    (1..6).each do |level|
      content = content.gsub(/<h#{level}[^>]*>(.*?)<\/h#{level}>/mi, "\n#{'#' * level} \\1\n\n")
    end
    
    # Convert strong/bold
    content = content.gsub(/<(?:strong|b)(?:\s[^>]*)?>([^<]*)<\/(?:strong|b)>/mi, "**\\1**")
    
    # Convert emphasis/italic
    content = content.gsub(/<(?:em|i)(?:\s[^>]*)?>([^<]*)<\/(?:em|i)>/mi, "*\\1*")
    
    # Convert links
    content = content.gsub(/<a\s+(?:[^>]*\s+)?href=["\']([^"\']*)["\'][^>]*>([^<]*)<\/a>/mi, "[\\2](\\1)")
    
    # Convert images
    content = content.gsub(/<img\s+(?:[^>]*\s+)?src=["\']([^"\']*)["\'][^>]*alt=["\']([^"\']*)["\'][^>]*\/?>/mi, "![\\2](\\1)")
    content = content.gsub(/<img\s+(?:[^>]*\s+)?src=["\']([^"\']*)["\'][^>]*\/?>/mi, "![Image](\\1)")
    
    # Convert lists
    content = content.gsub(/<ul[^>]*>(.*?)<\/ul>/mi) do
      list_content = $1
      list_content.gsub(/<li[^>]*>(.*?)<\/li>/mi, "- \\1\n")
    end
    
    content = content.gsub(/<ol[^>]*>(.*?)<\/ol>/mi) do
      list_content = $1
      counter = 0
      list_content.gsub(/<li[^>]*>(.*?)<\/li>/mi) do
        counter += 1
        "#{counter}. #{$1}\n"
      end
    end
    
    # Convert blockquotes
    content = content.gsub(/<blockquote[^>]*>(.*?)<\/blockquote>/mi, "> \\1\n\n")
    
    # Convert code blocks
    content = content.gsub(/<pre[^>]*><code[^>]*>(.*?)<\/code><\/pre>/mi, "```\n\\1\n```\n\n")
    content = content.gsub(/<pre[^>]*>(.*?)<\/pre>/mi, "```\n\\1\n```\n\n")
    content = content.gsub(/<code[^>]*>(.*?)<\/code>/mi, "`\\1`")
    
    # Convert line breaks
    content = content.gsub(/<br\s*\/?>/mi, "\n")
    
    # Remove remaining HTML tags
    content = content.gsub(/<[^>]+>/, '')
    
    # Decode HTML entities
    content = content.gsub(/&nbsp;/, ' ')
                    .gsub(/&amp;/, '&')
                    .gsub(/&lt;/, '<')
                    .gsub(/&gt;/, '>')
                    .gsub(/&quot;/, '"')
                    .gsub(/&#8217;/, "'")
                    .gsub(/&#8220;/, '"')
                    .gsub(/&#8221;/, '"')
                    .gsub(/&#8211;/, '–')
                    .gsub(/&#8212;/, '—')
                    .gsub(/&#8230;/, '…')
                    .gsub(/&hellip;/, '…')
                    .gsub(/&ldquo;/, '"')
                    .gsub(/&rdquo;/, '"')
                    .gsub(/&lsquo;/, "'")
                    .gsub(/&rsquo;/, "'")
    
    # Clean up excessive whitespace
    content = content.gsub(/\n{3,}/, "\n\n").strip
    
    return content
  end

  def generate_front_matter(title, date, categories, tags, excerpt)
    front_matter = "---\n"
    front_matter += "layout: post\n"
    front_matter += "title: \"#{title.gsub('"', '\\"')}\"\n"
    front_matter += "date: #{date.strftime('%Y-%m-%d %H:%M:%S %z')}\n"
    
    if categories.any?
      front_matter += "categories: [#{categories.map { |c| "\"#{c.gsub('"', '\\"')}\"" }.join(', ')}]\n"
    end
    
    if tags.any?
      front_matter += "tags: [#{tags.map { |t| "\"#{t.gsub('"', '\\"')}\"" }.join(', ')}]\n"
    end
    
    if excerpt && !excerpt.strip.empty?
      # Clean excerpt of HTML
      clean_excerpt = excerpt.gsub(/<[^>]+>/, '').strip
      unless clean_excerpt.empty?
        front_matter += "excerpt: \"#{clean_excerpt.gsub('"', '\\"')}\"\n"
      end
    end
    
    front_matter
  end
end

# Run the migration
if __FILE__ == $0
  xml_path = '/Users/judytuna/src/judytuna-dot-com/tunasays.WordPress.2025-08-30.xml'
  jekyll_path = '/Users/judytuna/src/judytuna-dot-com/judytuna-jekyll/_posts'
  
  unless File.exist?(xml_path)
    puts "WordPress XML file not found: #{xml_path}"
    exit 1
  end
  
  unless Dir.exist?(jekyll_path)
    puts "Jekyll posts directory not found: #{jekyll_path}"
    exit 1
  end
  
  migrator = WordPressXMLToJekyll.new(xml_path, jekyll_path)
  migrator.migrate_all
end