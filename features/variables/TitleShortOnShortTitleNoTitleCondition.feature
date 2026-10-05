Feature: variables
  As a CSL cite processor hacker
  I want the test variables_TitleShortOnShortTitleNoTitleCondition to pass

  @citation @variables @citation-items
  Scenario: Title Short On Short Title No Title Condition
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
          <choose>
            <if variable="title-short">
              <group delimiter=" ">
                <text variable="title"/>
                <group>
                  <text value="has title-short"/>
                </group>
              </group>
            </if>
            <else>
              <group delimiter=" ">
                <text variable="title"/>
                <group>
                  <text value="does not have title-short"/>
                </group>
              </group>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"My Long Title 1","title-short":"My Short Title","type":"book"},{"id":"ITEM-2","title":"My Long Title 2","type":"book"},{"id":"ITEM-3","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}],[{"id":"ITEM-3"}]]
    """
    Then the results should be:
      | My Long Title 1 has title-short |
      | My Long Title 2 does not have title-short |
      | does not have title-short |
