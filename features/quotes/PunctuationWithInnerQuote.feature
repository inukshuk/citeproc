Feature: quotes
  As a CSL cite processor hacker
  I want the test quotes_PunctuationWithInnerQuote to pass

  @bibliography @quotes @non-standard
  Scenario: Punctuation With Inner Quote
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <locale>
        <style-options punctuation-in-quote="true"/>
      </locale>
      <citation>
        <layout>
          <text value="Ignore me" />
        </layout>
      </citation>
      <bibliography>
        <layout>
          <text variable="title" quotes="true" suffix="."/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"item-1","title":"This is 'The One'","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">“This is ‘The One.’”</div>
    </div>
    """
