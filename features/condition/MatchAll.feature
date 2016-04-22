Feature: condition
  As a CSL cite processor hacker
  I want the test condition_MatchAll to pass

  @citation @condition
  Scenario: Match All
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
            <if variable="URL accessed" match="all">
              <date variable="accessed" prefix="viewed">
                <date-part name="day" form="numeric" suffix=" "/>
                <date-part name="month" form="long" suffix=" "/>
                <date-part name="year" form="long"/>
              </date>			  
              <text variable="URL" prefix=", &lt;" suffix="&gt;"/>
            </if>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"accessed":{"date-parts":[["1965","6","1"]]},"id":"ITEM-1","title":"Some Title or Other","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Some Title or Other
    """
