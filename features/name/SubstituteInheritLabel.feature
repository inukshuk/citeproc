Feature: name
  As a CSL cite processor hacker
  I want the test name_SubstituteInheritLabel to pass

  @citation @name
  Scenario: Substitute Inherit Label
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
      <locale>
        <terms>
          <term name="et-al">hello</term>
        </terms>
      </locale>
      <citation>
        <layout delimiter="; " prefix="[" suffix="]">
          <names prefix="[X]" variable="author">
            <name />
            <label form="short" prefix=" (" suffix=".)" font-style="italic"/>
            <substitute>
              <names variable="editor" />
            </substitute>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"editor":[{"family":"Roe","given":"Jane","static-ordering":false}],"id":"item-1","issued":{"date-parts":[["2000"]]},"title":"Her Anonymous Anthology","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"simple-western-name-1","issued":{"date-parts":[["1965","6","1"]]},"title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    [[X]Jane Roe (<i>ed.</i>); [X]John Doe]
    """
