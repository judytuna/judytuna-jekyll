#!/usr/bin/env ruby
require 'nokogiri'
require 'date'
require 'yaml'

class MissingPostsFinder
  def initialize(xml_file_path, jekyll_posts_path)
    @xml_file_path = xml_file_path
    @jekyll_posts_path = jekyll_posts_path
  end

  def find_missing
    puts "Analyzing WordPress XML to find missing posts..."
    
    # Get all published posts from WordPress XML
    wp_posts = extract_wordpress_posts
    puts "Found #{wp_posts.length} published posts in WordPress XML"
    
    # Get all migrated posts from Jekyll
    jekyll_posts = extract_jekyll_posts
    puts "Found #{jekyll_posts.length} posts in Jekyll"
    
    # Find missing posts
    missing_posts = find_missing_posts(wp_posts, jekyll_posts)
    
    if missing_posts.empty?
      puts "No missing posts found!"
    else
      puts "\nFound #{missing_posts.length} missing posts:"
      missing_posts.each_with_index do |post, i|
        puts "\n#{i+1}. Title: '#{post[:title]}'"
        puts "   Date: #{post[:date]}"
        puts "   Post ID: #{post[:post_id]}"
        puts "   Content length: #{post[:content] ? post[:content].length : 0} chars"
        puts "   Reason likely skipped: #{analyze_skip_reason(post)}"
      end
    end
  end

  private

  def extract_wordpress_posts
    posts = []
    doc = Nokogiri::XML(File.open(@xml_file_path))
    
    doc.xpath('//item').each do |item|
      post_type = extract_text(item, 'wp:post_type')
      status = extract_text(item, 'wp:status')
      
      # Only look at published posts
      next unless post_type == 'post' && status == 'publish'
      
      title = extract_text(item, 'title')
      pub_date = extract_text(item, 'pubDate')
      content = extract_text(item, 'content:encoded')
      post_id = extract_text(item, 'wp:post_id')
      
      begin
        date = DateTime.parse(pub_date) if pub_date
      rescue
        date = nil
      end
      
      posts << {
        title: title,
        date: date,
        content: content,
        post_id: post_id,
        pub_date_raw: pub_date
      }
    end
    
    posts
  end

  def extract_jekyll_posts
    posts = []
    Dir.glob(File.join(@jekyll_posts_path, '**/*.md')).each do |file|
      begin
        content = File.read(file)
        if content.match(/^---\s*\n(.*?\n?)^---\s*\n/m)
          front_matter = YAML.load($1)
          title = front_matter['title']
          date = front_matter['date']
          
          if title && date
            posts << {
              title: title,
              date: date.is_a?(String) ? DateTime.parse(date) : date,
              file: file
            }
          end
        end
      rescue => e
        puts "Warning: Could not process Jekyll file #{file}: #{e.message}"
      end
    end
    
    posts
  end

  def find_missing_posts(wp_posts, jekyll_posts)
    missing = []
    
    wp_posts.each do |wp_post|
      # Try to find matching Jekyll post
      found = jekyll_posts.any? do |jekyll_post|
        # Match by date and title (allowing for some variation)
        date_match = wp_post[:date] && jekyll_post[:date] && 
                    (wp_post[:date].strftime('%Y-%m-%d') == jekyll_post[:date].strftime('%Y-%m-%d'))
        
        title_match = normalize_title(wp_post[:title]) == normalize_title(jekyll_post[:title])
        
        date_match && title_match
      end
      
      unless found
        missing << wp_post
      end
    end
    
    missing
  end

  def normalize_title(title)
    return '' if title.nil? || title.strip.empty?
    title.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s+/, ' ').strip
  end

  def analyze_skip_reason(post)
    reasons = []
    
    reasons << "Missing/empty title" if post[:title].nil? || post[:title].strip.empty?
    reasons << "Missing/empty content" if post[:content].nil? || post[:content].strip.empty?
    reasons << "Invalid date" if post[:date].nil?
    reasons << "Content too short (#{post[:content]&.length} chars)" if post[:content] && post[:content].length < 10
    
    reasons.empty? ? "Unknown reason" : reasons.join(", ")
  end

  def extract_text(item, xpath)
    element = item.at_xpath(xpath)
    element ? element.text.strip : nil
  end
end

# Run the analysis
if __FILE__ == $0
  xml_path = '/Users/judytuna/src/judytuna-dot-com/tunasays.WordPress.2025-08-30.xml'
  jekyll_path = '/Users/judytuna/src/judytuna-dot-com/judytuna-jekyll/_posts'
  
  finder = MissingPostsFinder.new(xml_path, jekyll_path)
  finder.find_missing
end