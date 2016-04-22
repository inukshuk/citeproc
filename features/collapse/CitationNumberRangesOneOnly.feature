Feature: collapse
  As a CSL cite processor hacker
  I want the test collapse_CitationNumberRangesOneOnly to pass

  @bibliography @collapse @citations
  Scenario: Citation Number Ranges One Only
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
      <citation 
             collapse="citation-number">
        <layout>
          <text value="BOGUS"/>
        </layout>
      </citation>
      <bibliography>
        <layout suffix=".">
          <text variable="citation-number" prefix="[" suffix="]"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Paper 1","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">[1].</div>
    </div>
    """
