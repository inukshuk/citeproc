Feature: discretionary
  As a CSL cite processor hacker
  I want the test discretionary_CitationNumberSuppressAuthor to pass

  @citation @discretionary @citation-items
  Scenario: Citation Number Suppress Author
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
        <layout font-style="italic">
          <text prefix="[" suffix="]" variable="citation-number" />
        </layout>
      </citation>
      <bibliography>
        <layout>
          <text variable="title" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2005"]]},"title":"Book A","type":"book"},{"author":[{"family":"Jones","given":"Robert","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["2000"]]},"title":"Book B","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","suppress-author":1}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | <i>[1]</i> |
      | <i>[2]</i> |
