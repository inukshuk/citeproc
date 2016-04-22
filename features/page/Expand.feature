Feature: page
  As a CSL cite processor hacker
  I want the test page_Expand to pass

  @citation @page @citation-items
  Scenario: Expand
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
    [{"id":"ITEM-1","page":"110-5","title":"Example: minimal","type":"book"},{"id":"ITEM-2","page":"N110 - 5","title":"Example: prefix on one number only","type":"book"},{"id":"ITEM-3","page":"N110 - N5","title":"Example: same prefix on both numbers","type":"book"},{"id":"ITEM-4","page":"N110 - P5","title":"Example: different prefixes on both numbers","type":"book"},{"id":"ITEM-5","page":"123N110 - N5","title":"Example: leading number before prefix","type":"book"},{"id":"ITEM-6","page":"123N110 - N5, 456K200 - 99","title":"Example: multiple ranges","type":"book"},{"id":"ITEM-7","page":"123N110 - N5, 000c23 - 22","title":"Example: first less than second","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}],[{"id":"ITEM-3"}],[{"id":"ITEM-4"}],[{"id":"ITEM-5"}],[{"id":"ITEM-6"}],[{"id":"ITEM-7"}]]
    """
    Then the results should be:
      | Example: minimal, at 110–115                        |
      | Example: prefix on one number only, at N110–N115    |
      | Example: same prefix on both numbers, at N110–N115  |
      | Example: different prefixes on both numbers, at N110–P5 |
      | Example: leading number before prefix, at 123N110–N115 |
      | Example: multiple ranges, at 123N110–N115, 456K200–K299 |
      | Example: first less than second, at 123N110–N115, 000c23–22 |
