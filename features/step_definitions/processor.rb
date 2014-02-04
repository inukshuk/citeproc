Given(/^the following style:$/) do |string|
  @style = CSL::Style.parse!(string)
end

Given(/^the following input:$/) do |string|
  @input = JSON.parse(string)
  @input.should_not be_nil

  processor.import @input
end

Given(/^the following abbreviations:$/) do |string|
  processor.abbreviations = JSON.parse(string)
  processor.abbreviations[:default].should_not be_empty
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

When(/^I cite the following items:$/) do |string|
  @results = JSON.parse(string).map do |item|
    processor.process(item)
  end
end

When(/^I cite all items$/) do
  @result = processor.process @input.map { |i| { 'id' => i['id'] } }
end

Then(/^the bibliography's options should match:$/) do |table|
  headers = table.headers.map(&:to_sym)
  expected = table.rows[0]

  @bibliography.options.values_at(*headers).should == expected
end

Then(/^the results should be:$/) do |table|
  @results.should == table.raw.map(&:first)
end

Then(/^the result should be:$/) do |string|
  @result.should == string
end

