require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

# TODO: replace web_steps.rb

Допустим /^(?:|я )нахожусь на (.+)$/ do |ресурс|
  visit ресурс
end

Допустим /^(?:|я )захожу на (.+)$/ do |ресурс|
  visit ресурс
end

Тогда /^(?:|я )должен увидеть "([^"]*)"(?: внутри "([^"]*)")?$/ do |текст, область|
  with_scope(область) do
    page.respond_to?(:should) ? page.should(have_content(текст)) : assert(page.has_content?(текст))
  end
end
