Given /^short urls for business:$/ do |table|
  table.hashes.each do |row|
    ShortUrl.create(row)
  end
end

Then /^I should see( new)? short links:$/ do |create, table|
  has_css?('.history')
  table.hashes.each do |row|
    within('.history') do
      body.should include(row['origin'])
      create ? body.should(include(ShortUrl.find_by_origin(row['origin']).short)) : body.should(include(row['short']))
      body.should include(row['clicks_count'])
    end
  end
end


Then /^I should see message "([^\"]*)"$/ do |message|
  within('.status_bar') { body.should include(message) }
end