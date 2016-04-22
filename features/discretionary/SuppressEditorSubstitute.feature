Feature: discretionary
  As a CSL cite processor hacker
  I want the test discretionary_SuppressEditorSubstitute to pass

  @citation @discretionary @citation-items
  Scenario: Suppress Editor Substitute
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
        <layout delimiter="; " prefix="(" suffix=")">
          <group delimiter=" ">
            <names variable="author">
              <name />
              <substitute>
                <names variable="editor" />
              </substitute>
            </names>
            <date variable="issued">
              <date-part name="year" />
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"abstract":"An interesting book by an interesting author.","editor":[{"family":"Smith","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[["2005"]]},"title":"Book A","type":"book"},{"abstract":"An old contribution to a new field.","editor":[{"family":"Jones","given":"Robert"}],"id":"ITEM-2","issued":{"date-parts":[["2000"]]},"title":"Book B","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","suppress-author":1}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | (2005)              |
      | (Robert Jones 2000) |
