# Fix problem like
# .rvm/gems/ruby-1.9.2-p0/gems/rack-1.2.1/lib/rack/utils.rb:16: warning: regexp match /.../n against to UTF-8 string
module Rack
  module Utils
    def escape(s)
      EscapeUtils.escape_url(s)
    end
  end
end