# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based personal blog migrated from WordPress. The site uses the Minima theme with custom styling and includes migration scripts for data management.

## Development Commands

### Installation and Setup
```bash
bundle install                    # Install Ruby dependencies
```

### Local Development
```bash
bundle exec jekyll serve         # Start development server (localhost:4000)
bundle exec jekyll serve --drafts # Include draft posts
bundle exec jekyll build         # Build site to _site directory
bundle exec jekyll build --trace # Build with verbose error output
```

### Content Management
```bash
ruby migrate_posts.rb           # Migrate WordPress posts to Jekyll format
ruby find_missing_posts.rb      # Find posts missing from migration
ruby remove_duplicates.rb       # Remove duplicate posts
ruby extract_wordpress_media.rb # Extract media files from WordPress
```

## Architecture

### Directory Structure
- `_posts/YYYY/` - Blog posts organized by year in subdirectories
- `_layouts/` - Jekyll template files (default, home, post, year)
- `_includes/` - Reusable template components (header, footer, head)
- `_sass/` - SCSS stylesheets for custom styling
- `_site/` - Generated static site (excluded from git)
- `assets/` - Static assets (images, CSS, JS)

### Key Files
- `_config.yml` - Jekyll configuration with site settings, plugins, and permalink structure
- `Gemfile` - Ruby dependencies including Jekyll 4.4.1 and Minima theme
- `index.html` - Homepage using home layout with pagination
- `categories.html` and `tags.html` - Archive pages for content organization
- Year files (`2001.md` through `2025.md`) - Archive pages for posts by year

### Layouts
- `default.html` - Base layout template
- `home.html` - Homepage with post listing and pagination
- `post.html` - Individual blog post with categories, tags, and structured data
- `year.html` - Year-based archive pages

### Migration Scripts
The repository includes several Ruby scripts for WordPress-to-Jekyll migration:
- Data migration with category and tag preservation
- Duplicate detection and cleanup
- Media file extraction and organization
- Missing post identification

## Site Configuration
- URL: https://judytuna.com
- Theme: Minima with custom SCSS overrides
- Plugins: jekyll-feed, jekyll-paginate
- Permalink structure: `/:year/:month/:day/:title/`
- Pagination: 10 posts per page

## Content Organization
Posts are organized by year in the `_posts/` directory with the naming convention `YYYY-MM-DD-title.md`. The site supports categories and tags with dedicated archive pages.