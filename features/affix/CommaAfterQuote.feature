Feature: affix
  As a CSL cite processor hacker
  I want the test affix_CommaAfterQuote to pass

  @citation @affix @citation-items
  Scenario: Comma After Quote
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
      <citation>
        <layout>
          <text variable="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Hello Thing","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","prefix":"'quote', "}]]
    """
    Then the results should be:
      | “quote”, Hello Thing |
