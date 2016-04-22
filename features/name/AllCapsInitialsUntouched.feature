Feature: name
  As a CSL cite processor hacker
  I want the test name_AllCapsInitialsUntouched to pass

  @citation @name
  Scenario: All Caps Initials Untouched
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
          <group delimiter="; ">
            <group>
              <text value="Full: "/>
              <names variable="author">
                <name/>
              </names>
            </group>
            <group>
              <text value="Initialized: "/>
              <names variable="author">
                <name/>
              </names>
            </group>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"JH Hartcourt"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Full: JH Hartcourt Doe; Initialized: JH Hartcourt Doe
    """
