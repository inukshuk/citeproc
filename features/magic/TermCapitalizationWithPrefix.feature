Feature: magic
  As a CSL cite processor hacker
  I want the test magic_TermCapitalizationWithPrefix to pass

  @citation @magic @citations
  Scenario: Term Capitalization With Prefix
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
            <if position="first">
              <group delimiter=" ">
                <names variable="author">
                  <name form="short"/>
                </names>
                <date variable="issued" date-parts="year" form="text" prefix="(" suffix=")"/>
              </group>
            </if>
            <else>
              <text term="ibid"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[["1965"]]},"type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Doe (1965)
    ..[1] See ibid.
    ..[2] This has been said. Ibid.
    >>[3] Ibid.
    """
