Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_LastChar to pass

  @citation @textcase @citation-items
  Scenario: Last Char
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
          <text variable="title" text-case="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"07-x","type":"book"},{"id":"ITEM-2","title":"07-x test","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | 07-x      |
      | 07-x Test |
