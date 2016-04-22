Feature: substitute
  As a CSL cite processor hacker
  I want the test substitute_RepeatedNamesOk to pass

  @citation @substitute
  Scenario: Repeated Names Ok
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
              <name />
              <substitute>
                <names variable="editor"/>
              </substitute>
            </names>
            <names variable="author">
              <name />
              <substitute>
                <names variable="editor"/>
              </substitute>
            </names>
            <names variable="editor">
              <name />
              <substitute>
                <names variable="author"/>
              </substitute>
            </names>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Ry","given":"Ma"}],"editor":[{"family":"Kontrari","given":"Kwite"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Ma Ry, Ma Ry, Kwite Kontrari
    """
