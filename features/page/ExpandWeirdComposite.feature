Feature: page
  As a CSL cite processor hacker
  I want the test page_ExpandWeirdComposite to pass

  @citation @page @citation-items
  Scenario: Expand Weird Composite
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          page-range-format="expanded">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <text variable="title"/>
          <text variable="page" prefix=", at "/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"123N110 - N5, 456K200 - 99","title":"Example: weird composite","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | Example: weird composite, at 123N110-N5, 456K200-99 |
