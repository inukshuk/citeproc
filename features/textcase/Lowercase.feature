Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_Lowercase to pass

  @citation @textcase @non-standard
  Scenario: Lowercase
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
          <text variable="title" text-case="lowercase"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"This is a pen that is a <span class=\"nocase\">Smith</span> pencil","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    this is a pen that is a smith pencil
    """
