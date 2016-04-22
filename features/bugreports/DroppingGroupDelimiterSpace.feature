Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_DroppingGroupDelimiterSpace to pass

  @citation @bugreports
  Scenario: Dropping Group Delimiter Space
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
          <group delimiter=" ">
            <text variable="volume"/>
            <text variable="container-title" form="short" font-variant="small-caps"/>
            <text variable="page-first"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"Studia Patristica","id":"ITEM-1","page":"1388-1400","type":"article-journal","volume":"17"}]
    """
    When I cite all items
    Then the result should be:
    """
    17 <span style="font-variant:small-caps;">Studia Patristica</span> 1388
    """
