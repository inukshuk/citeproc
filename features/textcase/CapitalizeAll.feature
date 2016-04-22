Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_CapitalizeAll to pass

  @citation @textcase @non-standard
  Scenario: Capitalize All
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
          <text variable="title" text-case="capitalize-all"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"This IS a Pen that is a <span class=\"nocase\">SMITH</span> Pencil","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    This IS A Pen That Is A SMITH Pencil
    """
