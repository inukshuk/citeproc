Feature: name
  As a CSL cite processor hacker
  I want the test name_PeriodAfterInitials to pass

  @citation @name
  Scenario: Period After Initials
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
          <group delimiter=", ">
            <names variable="author">
              <name initialize-with=". " name-as-sort-order="first" sort-separator=", "/>
            </names>
            <text variable="title"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John Jeeves","static-ordering":false}],"id":"ITEM-1","title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Doe, J. J., His Anonymous Life
    """
