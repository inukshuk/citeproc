Feature: variables
  As a CSL cite processor hacker
  I want the test variables_TitleShortOnShortTitleNoTitleCondition to pass

  @citation @variables @citations
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
    [{"id":"ITEM-1","shortTitle":"My Short Title","title":"My Long Title 1","type":"book"},{"id":"ITEM-2","title":"My Long Title 2","type":"book"},{"id":"ITEM-3","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] My Long Title 1 has title-short
    ..[1] My Long Title 2 does not have title-short
    >>[2] does not have title-short
    """
