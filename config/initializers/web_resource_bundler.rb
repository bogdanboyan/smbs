# Turn on web resource bundler
WebResourceBundler::Bundler.setup(Rails.root, Rails.env)

ActionView::Base.send(:include, WebResourceBundler::RailsAppHelpers)
