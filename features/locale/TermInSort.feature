Feature: locale
  As a CSL cite processor hacker
  I want the test locale_TermInSort to pass

  @bibliography @locale @non-standard
  Scenario: Term In Sort
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.1mlz1">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <locale xml:lang="en-US">
        <terms>
          <term name="radio-broadcast">BBB</term>
          <term name="television-broadcast">AAA</term>
        </terms>
      </locale>
      <locale xml:lang="zh-TW">
        <terms>
          <term name="radio-broadcast">CCC</term>
          <term name="television-broadcast">DDD</term>
        </terms>
      </locale>
      <macro name="sort-key">
        <text macro="title-mac"/>
      </macro>
      <macro name="title-mac">
        <group delimiter=": ">
          <choose>
            <if genre="radio-broadcast">
              <text term="radio-broadcast"/>
            </if>
            <else-if genre="television-broadcast">
              <text term="television-broadcast"/>
            </else-if>
          </choose>
          <text variable="title"/>
        </group>
      </macro>
      <citation>
        <layout>
          <text value="NONE"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key macro="sort-key"/>
        </sort>
        <layout locale="zh-TW zh-CH">
          <text macro="title-mac"/>
        </layout>
        <layout>
          <text macro="title-mac"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"genre":"radio broadcast","id":"ITEM-1","language":"zh-TW","title":"Title 1","type":"broadcast"},{"genre":"television broadcast","id":"ITEM-2","language":"zh-TW","title":"Title 2","type":"broadcast"},{"genre":"zzzz","id":"ITEM-3","title":"Title 3","type":"broadcast"},{"genre":"zzzz","id":"ITEM-4","language":"qx-YY","title":"Title 4","type":"broadcast"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">CCC: Title 1</div>
      <div class="csl-entry">DDD: Title 2</div>
      <div class="csl-entry">Title 3</div>
      <div class="csl-entry">Title 4</div>
    </div>
    """
