# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based personal blog project for migrating content from WordPress to Jekyll. The repository is currently in its initial setup phase with GitHub Pages deployment configured.

## Development Commands

Since this is a new Jekyll project without a Gemfile yet, you'll need to initialize it first:

```bash
# Initialize Jekyll project (if not already done)
jekyll new . --force

# Install dependencies
bundle install

# Serve the site locally for development
bundle exec jekyll serve

# Build the site for production
bundle exec jekyll build

# Build and serve with live reloading
bundle exec jekyll serve --livereload
```

## Architecture

- **Deployment**: Automated via GitHub Actions (`.github/workflows/jekyll-gh-pages.yml`) 
- **Target Branch**: `main` (triggers automatic deployment)
- **Build Output**: `_site/` directory (ignored in git)
- **Content Format**: Markdown files with YAML front matter
- **Styling**: Will use Jekyll's default theme until customized

## Repository Status

This is a fresh Jekyll repository that needs initial setup. The GitHub Actions workflow is already configured for automatic deployment to GitHub Pages when changes are pushed to the main branch.

## Development Workflow

1. Make content or configuration changes
2. Test locally with `bundle exec jekyll serve`
3. Commit and push to main branch
4. GitHub Actions will automatically build and deploy to GitHub Pages