Feature: label
  As a CSL cite processor hacker
  I want the test label_MissingReturnsEmpty to pass

  @citation @label @citation-items
  Scenario: Missing Returns Empty
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
      <!-- locale>
        <term name="number">nummie</term>
      </locale -->
      <macro name="author">
        <names variable="author">
          <name form="short" />
          <label form="long" prefix=", "/>
        </names>
      </macro>
      <citation>
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | Aalto |
