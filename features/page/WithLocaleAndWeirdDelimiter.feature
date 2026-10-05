Feature: page
  As a CSL cite processor hacker
  I want the test page_WithLocaleAndWeirdDelimiter to pass

  @citation @page
  Scenario: With Locale And Weird Delimiter
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          page-range-format="chicago"
          default-locale="fr">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <text variable="page"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"253-257","title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    253‑57
    """
