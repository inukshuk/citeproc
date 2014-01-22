Given(/^the following style:$/) do |string|
  @style = CSL::Style.parse!(string)
end

Given(/^the following input:$/) do |string|
  @input = JSON.parse(string)
end

When(/^I render the bibliography$/) do
  cp = CiteProc::Processor.new :style => @style, :format => 'html'
  cp.import @input

  bib = cp.bibliography

  bib.errors?.should be_false

  bib.header = '<div class="csl-bib-body">'
  bib.footer = '</div>'

  bib.prefix = '  <div class="csl-entry">'
  bib.suffix = '</div>'

  @result = bib.join
end

Then(/^the result should be:$/) do |string|
  @result.should == string
end
