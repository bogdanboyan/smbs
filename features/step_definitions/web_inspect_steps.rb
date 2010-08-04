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

Когда /^(?:|я )кликну(?:| на) "([^"]*)"(?: внутри "([^"]*)")?$/ do |линк, область|
  with_scope(область) do
    click_link(линк)
  end
end

Когда /^(?:|я )заполню "([^"]*)" значением "([^"]*)"$/ do |поле, значение|
  fill_in(поле, :with => значение)
end

Когда /^(?:|я )нажму "([^"]*)"(?: внутри "([^"]*)")?$/ do |кнопка, область|
  with_scope(область) do
    click_button(кнопка)
  end
end

То /^(?:|я )должен увидеть форму:$/ do |с_полями|
  с_полями.hashes.each do |row|
    page.should have_content(row['label'])
    page.should have_field(row['field'])
  end
end

То /^(?:|я )должен увидеть кнопку "([^"]*)"$/ do |содержание|
  page.should have_button(содержание)
end

Тогда /^(?:|я )должен увидеть сообщение "([^"]*)"$/ do |сообщение|
  within('.status_bar') { body.should include(сообщение) }
end
