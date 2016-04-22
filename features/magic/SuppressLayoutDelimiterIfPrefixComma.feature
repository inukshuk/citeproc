Feature: magic
  As a CSL cite processor hacker
  I want the test magic_SuppressLayoutDelimiterIfPrefixComma to pass

  @citation @magic @citations
  Scenario: Suppress Layout Delimiter If Prefix Comma
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
        <layout delimiter="; ">
          <text variable="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book A","type":"book"},{"id":"ITEM-2","title":"Book B","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Book A, cited in Book B
    """
