Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_ChineseCharactersFamilyOnlyPluralLabel to pass

  @citation @bugreports
  Scenario: Chinese Characters Family Only Plural Label
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
          <names variable="editor">
            <name/>
    		<label form="short"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"editor":[{"family":"编者"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    编者ed.
    """
