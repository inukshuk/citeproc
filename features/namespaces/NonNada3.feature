Feature: namespaces
  As a CSL cite processor hacker
  I want the test namespaces_NonNada3 to pass

  @citation @namespaces
  Scenario: Non Nada3
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
          <text variable="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book A","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Book A
    """
