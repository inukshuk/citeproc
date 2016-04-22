Feature: name
  As a CSL cite processor hacker
  I want the test name_SubstituteMacroInheritDecorations to pass

  @citation @name
  Scenario: Substitute Macro Inherit Decorations
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
      <macro name="blob">
        <text value="I AM A BLOB" />
      </macro>
      <citation>
        <layout delimiter="; " prefix="[" suffix="]">
          <names variable="editor">
            <name />
            <substitute>
              <names variable="translator" />
              <text macro="blob" />
            </substitute>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"simple-western-name-1","issued":{"date-parts":[["1965","6","1"]]},"title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    [I AM A BLOB]
    """
