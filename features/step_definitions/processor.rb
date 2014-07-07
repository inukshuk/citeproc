Given(/^the following style:$/) do |string|
  @style = CSL::Style.parse!(string)
end

Given(/^the following input:$/) do |string|
  @input = JSON.parse(string)
  expect(@input).not_to be_nil

  processor.import @input
end

Given(/^the following abbreviations:$/) do |string|
  processor.abbreviations = JSON.parse(string)
  expect(processor.abbreviations[:default]).not_to be_empty
end

When(/^I render the entire bibliography$/) do
  @bibliography = processor.bibliography
  expect(@bibliography.errors).to eq([])
end

When(/^I render the following bibliography selection:$/) do |string|
  selection = JSON.parse(string)
  expect(selection).not_to be_nil

  @bibliography = processor.bibliography(selection)
  expect(@bibliography.errors).to eq([])
end

Then(/^the bibliography should be:$/) do |string|
  string.gsub!(/\n\s*/m, '') # strip newlines
  expect(@bibliography.join).to eq(string)
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

  expect(@bibliography.options.values_at(*headers)).to eq(expected)
end

Then(/^the results should be:$/) do |table|
  expect(@results).to eq(table.raw.map(&:first))
end

Then(/^the result should be:$/) do |string|
  expect(@result).to eq(string)
end

