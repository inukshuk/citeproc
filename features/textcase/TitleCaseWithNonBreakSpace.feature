Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_TitleCaseWithNonBreakSpace to pass

  @citation @textcase
  Scenario: Title Case With Non Break Space
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
          <text variable="title" text-case="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"The physical volcanology of the 1600 eruption of Huaynaputina","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    The Physical Volcanology of the 1600 Eruption of Huaynaputina
    """
