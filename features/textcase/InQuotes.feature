Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_InQuotes to pass

  @citation @textcase @citation-items
  Scenario: In Quotes
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
          <text text-case="title" variable="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"from \"distance\" to \"friction\": substituting metaphors and redirecting intercultural research for","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | From “Distance” to “Friction”: Substituting Metaphors and Redirecting Intercultural Research For |
