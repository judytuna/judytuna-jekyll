#!/usr/bin/env ruby
require 'nokogiri'
require 'net/http'
require 'uri'
require 'fileutils'

# Path to the WordPress XML export file
xml_file = '/Users/judytuna/src/judytuna-dot-com/tunasays.WordPress.2025-09-03.xml'
download_dir = 'assets/images'

puts "Processing WordPress media export..."
puts "=" * 50

# Parse the XML file
doc = Nokogiri::XML(File.open(xml_file))

# Extract all attachment items
attachments = doc.xpath('//item[wp:post_type="attachment"]', 'wp' => 'http://wordpress.org/export/1.2/')

puts "Found #{attachments.length} media attachments"

# Create download directory
FileUtils.mkdir_p(download_dir)

success_count = 0
failed_count = 0
media_urls = []

attachments.each_with_index do |attachment, index|
  title = attachment.xpath('title').text.strip
  guid = attachment.xpath('guid').text.strip
  attachment_url = attachment.xpath('wp:attachment_url', 'wp' => 'http://wordpress.org/export/1.2/').text.strip
  
  # Use attachment_url if available, otherwise use guid
  url = attachment_url.empty? ? guid : attachment_url
  
  next if url.empty?
  
  media_urls << {
    title: title,
    url: url,
    index: index + 1
  }
end

puts "Extracting #{media_urls.length} unique media URLs..."
puts "-" * 50

media_urls.each do |media|
  puts "[#{media[:index]}/#{media_urls.length}] #{media[:title]}"
  puts "  URL: #{media[:url]}"
  
  begin
    uri = URI(media[:url])
    
    # Create local path based on URL
    if uri.path.include?('/wp-content/uploads/')
      # Extract the path after /wp-content/uploads/
      local_path = uri.path.split('/wp-content/uploads/').last
    elsif uri.path.include?('/files/')
      # Handle older WordPress file structure
      local_path = uri.path.split('/files/').last
    else
      # Fallback: use the filename
      local_path = File.basename(uri.path)
    end
    
    full_local_path = File.join(download_dir, local_path)
    
    # Create directory if needed
    FileUtils.mkdir_p(File.dirname(full_local_path))
    
    # Skip if file already exists
    if File.exist?(full_local_path)
      puts "  ✓ Already exists: #{local_path}"
      success_count += 1
      next
    end
    
    # Download the file
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri)
      response = http.request(request)
      
      if response.code == '200'
        File.open(full_local_path, 'wb') do |file|
          file.write(response.body)
        end
        puts "  ✓ Downloaded: #{local_path} (#{response.body.length} bytes)"
        success_count += 1
      else
        puts "  ✗ Failed (HTTP #{response.code}): #{media[:url]}"
        failed_count += 1
      end
    end
    
  rescue => e
    puts "  ✗ Error: #{e.message}"
    failed_count += 1
  end
  
  # Be nice to the server
  sleep(0.5)
end

puts "\n" + "=" * 50
puts "Download Summary:"
puts "Successfully downloaded: #{success_count} files"
puts "Failed downloads: #{failed_count} files"
puts "Total processed: #{media_urls.length} files"
puts "\nAll media files saved to: #{File.expand_path(download_dir)}"