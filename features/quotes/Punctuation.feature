Feature: quotes
  As a CSL cite processor hacker
  I want the test quotes_Punctuation to pass

  @bibliography @quotes @non-standard
  Scenario: Punctuation
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
      <macro name="title">
        <text quotes="true" suffix="," variable="title" />
      </macro>
      <citation>
        <layout>
          <text value="Ignore me" />
        </layout>
      </citation>
      <bibliography>
        <layout>
          <text macro="title" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"item-1","issued":{"date-parts":[["2000"]]},"title":"The Book Title","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">“The Book Title,”</div>
    </div>
    """
