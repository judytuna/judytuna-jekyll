#!/usr/bin/env ruby
require 'yaml'

class DuplicateRemover
  def initialize(posts_dir)
    @posts_dir = posts_dir
    @removed_count = 0
  end

  def remove_duplicates
    puts "Scanning for duplicate posts in #{@posts_dir}..."
    
    # Group posts by date and title
    posts_by_content = {}
    
    Dir.glob(File.join(@posts_dir, '*.md')).each do |file|
      begin
        # Parse front matter
        content = File.read(file)
        if content.match(/^---\s*\n(.*?\n?)^---\s*\n(.*)/m)
          front_matter = YAML.load($1)
          date = front_matter['date']
          title = front_matter['title']
          
          # Create a key based on date and title
          key = "#{date.strftime('%Y-%m-%d') rescue date.to_s}-#{title}"
          
          posts_by_content[key] ||= []
          posts_by_content[key] << {
            file: file,
            filename: File.basename(file),
            title: title,
            date: date
          }
        end
      rescue => e
        puts "Error processing #{file}: #{e.message}"
      end
    end
    
    # Find and remove duplicates
    posts_by_content.each do |key, posts|
      next if posts.length <= 1
      
      puts "\nFound #{posts.length} duplicates for: #{key}"
      posts.each_with_index do |post, i|
        puts "  #{i + 1}. #{post[:filename]}"
      end
      
      # Keep the post with the better filename (non-generic)
      # Priority: descriptive slug > post-XXXX > numeric
      posts.sort! do |a, b|
        a_generic = a[:filename].include?('post-')
        b_generic = b[:filename].include?('post-')
        a_numeric = a[:filename].match?(/\d+-\d+-\d+-\d+\.md$/)
        b_numeric = b[:filename].match?(/\d+-\d+-\d+-\d+\.md$/)
        
        if a_generic && !b_generic
          1  # b is better (descriptive)
        elsif !a_generic && b_generic  
          -1 # a is better (descriptive)
        elsif a_numeric && !b_numeric
          1  # b is better (non-numeric)
        elsif !a_numeric && b_numeric
          -1 # a is better (non-numeric)
        else
          0  # same priority, keep first
        end
      end
      
      # Keep the first (best) post, remove the rest
      keep = posts.first
      remove = posts[1..-1]
      
      puts "  Keeping: #{keep[:filename]}"
      remove.each do |post|
        puts "  Removing: #{post[:filename]}"
        File.delete(post[:file])
        @removed_count += 1
      end
    end
    
    puts "\nRemoved #{@removed_count} duplicate posts"
    
    # Final count
    remaining_count = Dir.glob(File.join(@posts_dir, '*.md')).length
    puts "Remaining posts: #{remaining_count}"
  end
end

# Run the duplicate removal
if __FILE__ == $0
  posts_path = '/Users/judytuna/src/judytuna-dot-com/judytuna-jekyll/_posts'
  
  unless Dir.exist?(posts_path)
    puts "Posts directory not found: #{posts_path}"
    exit 1
  end
  
  remover = DuplicateRemover.new(posts_path)
  remover.remove_duplicates
end