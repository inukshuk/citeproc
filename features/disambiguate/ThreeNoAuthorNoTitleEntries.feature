Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_ThreeNoAuthorNoTitleEntries to pass

  @bibliography @disambiguate @citations
  Scenario: Three No Author No Title Entries
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
      <citation et-al-min="4" et-al-use-first="1" disambiguate-add-names="true">
        <layout>
          <group delimiter=", ">
            <choose>
              <if position="subsequent">
                <names variable="author">
                  <name/>
                </names>
              </if>
              <else-if position="first">
                <names variable="author">
                  <name/>
                </names>
                <text variable="container-title"/>
                <date variable="issued" form="text" date-parts="year"/>
              </else-if>
            </choose>
          </group>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter=", ">
            <names variable="author">
              <name/>
            </names>
            <text variable="container-title"/>
            <date variable="issued" form="text" date-parts="year"/>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"container-title":"BleagleA","id":"ITEM-1","issued":{"date-parts":[[2000]]},"type":"book"},{"container-title":"BleagleB","id":"ITEM-2","issued":{"date-parts":[[2000]]},"type":"book"},{"container-title":"BleagleC","id":"ITEM-3","issued":{"date-parts":[[2000]]},"type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">BleagleA, 2000</div>
      <div class="csl-entry">BleagleB, 2000</div>
      <div class="csl-entry">BleagleC, 2000</div>
    </div>
    """
