Feature: date
  As a CSL cite processor hacker
  I want the test date_YearSuffixImplicitWithNoDateOneOnly to pass

  @citation @date @citations
  Scenario: Year Suffix Implicit With No Date One Only
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
      <citation disambiguate-add-year-suffix="true">
        <layout delimiter="; " prefix="(" suffix=")">
          <group delimiter=" ">
            <names variable="author">
              <name/>
            </names>
            <group>
              <choose>
                <if variable="issued">
                  <date variable="issued" form="text" date-parts="year"/>
                  <text variable="year-suffix"/>
                </if>
                <else>
                  <text term="no date" form="short"/>
                  <text variable="year-suffix" prefix="-"/>
                </else>
              </choose>
            </group>
          </group>
          <group delimiter=" " prefix=" [" suffix="]">
            <text term="accessed" suffix=": " text-case="capitalize-first"/>
            <date variable="accessed" form="text" date-parts="year-month-day"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"accessed":{"date-parts":[["1965","6","1"]]},"author":[{"family":"Doe","given":"John"}],"id":"ITEM-1","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] (John Doe n.d. [Accessed: June 1, 1965])
    """
