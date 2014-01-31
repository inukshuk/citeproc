Given(/^the following style:$/) do |string|
  @style = CSL::Style.parse!(string)
end

Given(/^the following input:$/) do |string|
  @input = JSON.parse(string)
end

When(/^I render the entire bibliography$/) do
  @input.should_not be_nil

  processor.import @input
  @bibliography = processor.bibliography

  @bibliography.errors.should == []
end

Then(/^the bibliography should be:$/) do |string|
  string.gsub!(/\n\s*/m, '') # strip newlines
  @bibliography.join.should == string
end
