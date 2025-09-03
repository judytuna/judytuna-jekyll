#!/usr/bin/env ruby
require 'yaml'
require 'date'
require 'fileutils'

class MainDuplicateRemover
  def initialize(posts_dir)
    @posts_dir = posts_dir
    @removed_count = 0
    @kept_count = 0
  end

  def remove_duplicates
    puts "Removing duplicates from #{@posts_dir}..."
    
    posts = load_all_posts
    puts "Found #{posts.length} total posts"
    
    # Find and remove same-day duplicates (likely timezone issues)
    remove_same_day_duplicates(posts)
    
    puts "\nDuplicate removal complete!"
    puts "Kept: #{@kept_count} posts"
    puts "Removed: #{@removed_count} duplicates"
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

  def remove_same_day_duplicates(posts)
    # Group by normalized title
    title_groups = {}
    posts.each do |post|
      next unless post[:title] && post[:parsed_date]
      
      normalized_title = post[:title].downcase.gsub(/[^\w\s]/, '').gsub(/\s+/, ' ').strip
      next if normalized_title.empty?
      
      title_groups[normalized_title] ||= []
      title_groups[normalized_title] << post
    end
    
    # Process groups with potential duplicates
    title_groups.each do |title, posts_with_title|
      if posts_with_title.length > 1
        process_title_group(title, posts_with_title)
      else
        @kept_count += posts_with_title.length
      end
    end
  end

  def process_title_group(title, posts)
    # Sort by date
    sorted_posts = posts.sort_by { |p| p[:parsed_date] }
    
    i = 0
    while i < sorted_posts.length
      current_post = sorted_posts[i]
      duplicates = [current_post]
      
      # Look for posts within the same day
      j = i + 1
      while j < sorted_posts.length
        next_post = sorted_posts[j]
        
        # Check if same day (allowing for timezone differences)
        if same_day?(current_post[:parsed_date], next_post[:parsed_date])
          duplicates << next_post
          j += 1
        else
          break
        end
      end
      
      if duplicates.length > 1
        process_duplicate_group(title, duplicates)
        i = j
      else
        @kept_count += 1
        i += 1
      end
    end
  end

  def same_day?(date1, date2)
    return false unless date1 && date2
    
    # Convert to same timezone for comparison
    date1_utc = date1.to_time.utc.to_date
    date2_utc = date2.to_time.utc.to_date
    
    # Allow for 1 day difference (timezone issues)
    (date1_utc - date2_utc).abs <= 1
  end

  def process_duplicate_group(title, duplicates)
    puts "\n--- Processing #{duplicates.length} duplicates for '#{title}' ---"
    
    # Sort by preference: keep the most complete/recent one
    sorted_duplicates = duplicates.sort_by do |post|
      [
        # Prefer larger files (more complete content)
        -post[:file_size],
        # Prefer posts with WordPress ID
        post[:wordpress_id] ? 0 : 1,
        # Prefer later dates (more recent/complete versions)
        -(post[:parsed_date].to_i)
      ]
    end
    
    # Keep the first (best) post
    keep_post = sorted_duplicates.first
    remove_posts = sorted_duplicates[1..-1]
    
    puts "KEEPING: #{keep_post[:filename]}"
    puts "  Title: #{keep_post[:title]}"
    puts "  Date: #{keep_post[:date]}"
    puts "  Size: #{keep_post[:file_size]} bytes"
    puts "  Path: #{keep_post[:file_path]}"
    
    remove_posts.each do |post|
      puts "REMOVING: #{post[:filename]}"
      puts "  Date: #{post[:date]}"
      puts "  Size: #{post[:file_size]} bytes"
      puts "  Path: #{post[:file_path]}"
      puts "  Reason: Smaller/older duplicate"
      
      File.delete(post[:file_path])
      @removed_count += 1
    end
    
    @kept_count += 1
  end
end

# Run the duplicate removal
if __FILE__ == $0
  posts_dir = '_posts'
  
  remover = MainDuplicateRemover.new(posts_dir)
  remover.remove_duplicates
end