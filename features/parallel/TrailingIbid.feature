Feature: parallel
  As a CSL cite processor hacker
  I want the test parallel_TrailingIbid to pass

  @citation @parallel @citations
  Scenario: Trailing Ibid
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
      <citation year-suffix-delimiter=", ">
        <layout delimiter="; " suffix=".">
          <choose>
          <if position="first">
            <group delimiter=", ">
              <text variable="title"/>
              <group delimiter=" ">
                <text variable="volume"/>
                <text variable="container-title"/>
                <group>
                  <text variable="page"/>
                  <text variable="locator" prefix=", "/>
                </group>
                <date variable="issued" date-parts="year" form="text" prefix="(" suffix=")"/>
              </group>
            </group>
          </if>
          <else-if position="ibid-with-locator">
            <text term="ibid"/>
            <text variable="locator" prefix=" at "/>
          </else-if>
          <else-if position="ibid">
            <text term="ibid"/>
          </else-if>
          <else-if position="subsequent">
            <group delimiter=", ">
              <text variable="title"/>
              <group delimiter=" ">
                <text variable="volume"/>
                <text variable="container-title"/>
                <text variable="locator"/>
              </group>
            </group>
          </else-if>
          <else>
            <text value="WTF?"/>
          </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"U.S.","id":"ITEM-1","issued":{"date-parts":[["1965"]]},"page":"200","title":"Smith v. Noakes","type":"legal_case","volume":"222"},{"container-title":"L.Ed.","id":"ITEM-2","issued":{"date-parts":[["1965"]]},"page":"300","title":"Smith v. Noakes","type":"legal_case","volume":"333"},{"container-title":"U.S.","id":"ITEM-3","issued":{"date-parts":[["1966"]]},"page":"400","title":"Jim v. Bob","type":"legal_case","volume":"444"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Smith v. Noakes, 222 U.S. 200, 201, 333 L.Ed. 300, 301 (1965); ibid., 333 L.Ed. 301; Jim v. Bob, 444 U.S. 400, 401 (1966).
    """
