Feature: locale
  As a CSL cite processor hacker
  I want the test locale_NonExistentLocaleDef to pass

  @citation @locale
  Scenario: Non Existent Locale Def
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          default-locale="gx">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <locale xml:lang="gx">
        <terms>
          <term name="editor">edxitor</term>
        </terms>
      </locale>
      <citation>
        <layout>
          <group delimiter=" + ">
            <names variable="editor">
              <name/>
              <label prefix=" (" suffix=")"/>
            </names>
            <names variable="translator">
              <name/>
              <label prefix=" (" suffix=")"/>
            </names>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"editor":[{"family":"Doe","given":"John"}],"id":"ITEM-1","translator":[{"family":"roe","given":"Jane"}],"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John Doe (edxitor) + Jane roe (translator)
    """
