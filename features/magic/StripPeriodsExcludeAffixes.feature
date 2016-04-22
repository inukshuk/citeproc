Feature: magic
  As a CSL cite processor hacker
  I want the test magic_StripPeriodsExcludeAffixes to pass

  @citation @magic
  Scenario: Strip Periods Exclude Affixes
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
      <macro name="container-title">
        <text strip-periods="true" variable="container-title" form="short"/>
      </macro>
      <macro name="author">
        <names variable="author" >
          <name and="symbol" delimiter-precedes-last="never" />
        </names>
      </macro>
      <citation>
        <layout delimiter="." suffix=".">
          <group delimiter=".">
            <text macro="author"/>
            <text macro="container-title"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"}],"container-title":"Journal Title","id":"ITEM-1","type":"article-journal"},{"author":[{"family":"Roe","given":"Jane"}],"container-title":"Journ. Title","id":"ITEM-2","type":"article-journal"}]
    """
    When I cite all items
    Then the result should be:
    """
    John Doe.Journal Title.Jane Roe.Journ Title.
    """
