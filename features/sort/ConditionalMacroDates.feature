Feature: sort
  As a CSL cite processor hacker
  I want the test sort_ConditionalMacroDates to pass

  @bibliography @sort
  Scenario: Conditional Macro Dates
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
      <macro name="issued-date">
        <group prefix="[" suffix="]">
        <text variable="title"/>
        <choose>
          <if type="book">
            <date variable="issued">
              <date-part name="year" form="long"/>
            </date>
          </if>
          <else>
            <date variable="issued">
              <date-part name="year" form="long" suffix="-"/>
              <date-part name="month" form="numeric" suffix="-"/>
              <date-part name="day" form="numeric"/>
            </date>
          </else>
        </choose>
        </group>
      </macro>
      <citation>
        <layout>
          <text value="bogus"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key macro="issued-date" sort="ascending"/>
        </sort>
        <layout>
          <text variable="title" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"item-1","issued":{"date-parts":[[2002,12,25]]},"title":"Title 2","type":"article-journal"},{"id":"item-2","issued":{"date-parts":[[2002,11,30]]},"title":"Title 3","type":"book"},{"id":"item-3","issued":{"date-parts":[[2002,10,25]]},"title":"Title 1","type":"article-journal"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Title 3</div>
      <div class="csl-entry">Title 1</div>
      <div class="csl-entry">Title 2</div>
    </div>
    """
