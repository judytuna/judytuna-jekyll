#!/usr/bin/env ruby
require 'yaml'
require 'digest'
require 'date'

class MainDuplicateDetector
  def initialize(posts_dir)
    @posts_dir = posts_dir
  end

  def detect_duplicates
    puts "Analyzing posts for duplicates in #{@posts_dir}..."
    
    posts = load_all_posts
    puts "Found #{posts.length} total posts"
    
    # Group posts by content similarity
    content_groups = group_by_content(posts)
    
    # Group posts by title similarity  
    title_groups = group_by_title(posts)
    
    # Group posts by close dates
    date_groups = group_by_close_dates(posts)
    
    puts "\n=== CONTENT DUPLICATES ==="
    report_duplicates(content_groups, "content")
    
    puts "\n=== TITLE DUPLICATES ==="
    report_duplicates(title_groups, "title")
    
    puts "\n=== CLOSE DATE DUPLICATES ==="
    report_close_date_duplicates(date_groups)
  end

  private

  def load_all_posts
    posts = []
    
    Dir.glob(File.join(@posts_dir, '**/*.md')).each do |file|
      posts << load_post_data(file)
    end
    
    posts.compact
  end

  def load_post_data(file_path)
    begin
      content = File.read(file_path)
      
      if content.match(/^---\s*\n(.*?)\n^---\s*\n(.*)$/m)
        front_matter = YAML.load($1)
        body_content = $2
        
        return {
          file_path: file_path,
          filename: File.basename(file_path),
          title: front_matter['title'],
          date: front_matter['date'],
          wordpress_id: front_matter['wordpress_id'],
          body_content: body_content.strip,
          content_hash: generate_content_hash(front_matter['title'], body_content),
          title_hash: generate_title_hash(front_matter['title']),
          file_size: File.size(file_path),
          parsed_date: parse_date(front_matter['date'])
        }
      end
    rescue => e
      puts "Warning: Could not process #{file_path}: #{e.message}"
      return nil
    end
  end

  def parse_date(date_str)
    return nil unless date_str
    case date_str
    when String
      DateTime.parse(date_str) rescue nil
    when Date, DateTime, Time
      date_str
    else
      nil
    end
  end

  def generate_content_hash(title, content)
    normalized_title = (title || '').downcase.gsub(/[^\w\s]/, '').gsub(/\s+/, ' ').strip
    normalized_content = content.to_s.downcase.gsub(/[^\w\s]/, '').gsub(/\s+/, ' ').strip
    Digest::SHA256.hexdigest("#{normalized_title}|#{normalized_content}")
  end

  def generate_title_hash(title)
    return nil unless title
    normalized = title.downcase.gsub(/[^\w\s]/, '').gsub(/\s+/, ' ').strip
    Digest::SHA256.hexdigest(normalized)
  end

  def group_by_content(posts)
    groups = {}
    posts.each do |post|
      hash = post[:content_hash]
      groups[hash] ||= []
      groups[hash] << post
    end
    groups.select { |_, group| group.length > 1 }
  end

  def group_by_title(posts)
    groups = {}
    posts.each do |post|
      next unless post[:title_hash]
      hash = post[:title_hash]
      groups[hash] ||= []
      groups[hash] << post
    end
    groups.select { |_, group| group.length > 1 }
  end

  def group_by_close_dates(posts)
    # Group posts that have the same title and dates within 2 days of each other
    title_date_groups = {}
    
    posts.each do |post|
      next unless post[:parsed_date] && post[:title]
      
      normalized_title = post[:title].downcase.gsub(/[^\w\s]/, '').gsub(/\s+/, ' ').strip
      next if normalized_title.empty?
      
      title_date_groups[normalized_title] ||= []
      title_date_groups[normalized_title] << post
    end
    
    # Find groups where posts have close dates
    close_groups = {}
    title_date_groups.each do |title, posts_with_title|
      next if posts_with_title.length <= 1
      
      # Sort by date
      sorted_posts = posts_with_title.sort_by { |p| p[:parsed_date] }
      
      # Check for posts within 2 days of each other
      i = 0
      while i < sorted_posts.length - 1
        group = [sorted_posts[i]]
        current_date = sorted_posts[i][:parsed_date]
        
        j = i + 1
        while j < sorted_posts.length
          next_date = sorted_posts[j][:parsed_date]
          days_diff = (next_date.to_date - current_date.to_date).abs
          
          if days_diff <= 2
            group << sorted_posts[j]
            j += 1
          else
            break
          end
        end
        
        if group.length > 1
          key = "#{title}_#{current_date.strftime('%Y-%m-%d')}"
          close_groups[key] = group
        end
        
        i = j > i + 1 ? j : i + 1
      end
    end
    
    close_groups
  end

  def report_duplicates(groups, type)
    if groups.empty?
      puts "No #{type} duplicates found."
      return
    end
    
    groups.each do |hash, group|
      puts "\n--- #{group.length} posts with same #{type} ---"
      group.each do |post|
        puts "#{post[:filename]} - '#{post[:title]}' (#{post[:date]}) [#{post[:file_size]} bytes]"
      end
    end
  end

  def report_close_date_duplicates(groups)
    if groups.empty?
      puts "No close date duplicates found."
      return
    end
    
    groups.each do |key, group|
      puts "\n--- #{group.length} posts with same title and close dates ---"
      group.each do |post|
        puts "#{post[:filename]} - '#{post[:title]}' (#{post[:date]}) [#{post[:file_size]} bytes]"
      end
    end
  end
end

# Run the detection
if __FILE__ == $0
  posts_dir = '_posts'
  
  detector = MainDuplicateDetector.new(posts_dir)
  detector.detect_duplicates
end