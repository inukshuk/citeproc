Given(/^the following style:$/) do |string|
  @style = CSL::Style.parse!(string)
end

Given(/^the following input:$/) do |string|
  @input = JSON.parse(string)
  @input.should_not be_nil

  processor.import @input
end

When(/^I render the entire bibliography$/) do
  @bibliography = processor.bibliography
  @bibliography.errors.should == []
end

When(/^I render the following bibliography selection:$/) do |string|
  selection = JSON.parse(string)
  selection.should_not be_nil

  @bibliography = processor.bibliography(selection)
  @bibliography.errors.should == []
end

Then(/^the bibliography should be:$/) do |string|
  string.gsub!(/\n\s*/m, '') # strip newlines
  @bibliography.join.should == string
end

When(/^I cite all items$/) do
  items = Hash[@input.map { |i| ['id', i['id']] }]
  @result = processor.process items
end

Then(/^the bibliography's options should match:$/) do |table|
  headers = table.headers.map(&:to_sym)
  expected = table.rows[0]

  @bibliography.options.values_at(*headers).should == expected
end

Then(/^the result should be:$/) do |string|
  @result.should == string
end

