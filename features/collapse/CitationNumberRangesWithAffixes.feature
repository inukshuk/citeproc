Feature: collapse
  As a CSL cite processor hacker
  I want the test collapse_CitationNumberRangesWithAffixes to pass

  @citation @collapse @citations
  Scenario: Citation Number Ranges With Affixes
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
        <layout delimiter="," font-weight="bold" prefix="(" suffix=")">
          <text variable="citation-number" prefix="[" suffix="]"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Paper 1","type":"book"},{"id":"ITEM-2","title":"Paper 2","type":"book"},{"id":"ITEM-3","title":"Paper 3","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] <b>([1]–[3])</b>
    """
