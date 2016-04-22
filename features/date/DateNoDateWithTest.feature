Feature: date
  As a CSL cite processor hacker
  I want the test date_DateNoDateWithTest to pass

  @citation @date
  Scenario: Date No Date With Test
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
          <text variable="title"/>
          <choose>
            <if variable="issued">
              <date prefix=" (" suffix=")" variable="issued">
                <date-part form="long" name="month" />
                <date-part name="day" suffix=", " />
                <date-part name="year" />
              </date>
            </if>
            <else>
              <text term="no date" form="short" prefix=" (" suffix=")"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Title Thing","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Title Thing (n.d.)
    """
