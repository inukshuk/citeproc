Feature: date
  As a CSL cite processor hacker
  I want the test date_NegativeDateSortViaMacroOnYearMonthOnly to pass

  @citation @date
  Scenario: Negative Date Sort Via Macro On Year Month Only
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
      <macro name="shortdate">
          <date variable="issued" delimiter="-">
            <date-part name="year"/>
            <date-part name="month" form="numeric"/>
          </date>
      </macro>
      <macro name="longdate">
          <date variable="issued" delimiter="-">
            <date-part name="year"/>
            <date-part name="month" form="numeric"/>
            <date-part name="day" form="numeric"/>
          </date>
      </macro>
      <citation>
        <sort>
          <key macro="shortdate"/>
          <key variable="title"/>
        </sort>
        <layout delimiter=", ">
          <group delimiter=" ">
            <text variable="title"/>
            <text macro="longdate" prefix="(" suffix=")"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[[-100,7,13]]},"title":"BookY","type":"book"},{"id":"ITEM-2","issued":{"date-parts":[[-100,7,14]]},"title":"BookX","type":"book"},{"id":"ITEM-3","issued":{"date-parts":[[68,3,15]]},"title":"BookB","type":"book"},{"id":"ITEM-4","issued":{"date-parts":[[68,3,16]]},"title":"BookA","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    BookX (100BC-7-14), BookY (100BC-7-13), BookA (68AD-3-16), BookB (68AD-3-15)
    """
