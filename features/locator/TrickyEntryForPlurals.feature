Feature: locator
  As a CSL cite processor hacker
  I want the test locator_TrickyEntryForPlurals to pass

  @citation @locator @citation-items
  Scenario: Tricky Entry For Plurals
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
          <term name="folio" form="short">fol.</term>
        </terms>
      </locale>
      <citation>
        <layout>
          <group delimiter=", ">
            <text variable="title" />
            <group delimiter=" ">
              <label variable="locator" form="short"/>
              <text variable="locator"/>
            </group>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book Title","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","locator":"vol. 1, fol. 186, 8 April 1544"}]]
    """
    Then the results should be:
      | Book Title, vol. 1, fol. 186, 8 April 1544 |
