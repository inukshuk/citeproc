Feature: date
  As a CSL cite processor hacker
  I want the test date_SortEmptyDatesCitation to pass

  @citation @date
  Scenario: Sort Empty Dates Citation
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
        <sort>
          <key variable="issued"/>
          <key variable="title"/>
        </sort>
        <layout delimiter="; " prefix="" suffix=".">
          <group delimiter=" ">
            <text variable="title" />
            <date variable="issued">
              <date-part name="year" />
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"BookA","type":"book"},{"id":"ITEM-2","issued":{"date-parts":[[2000]]},"title":"BookB","type":"book"},{"id":"ITEM-3","title":"BookC","type":"book"},{"id":"ITEM-4","issued":{"date-parts":[[1999]]},"title":"BookD","type":"book"},{"id":"ITEM-5","title":"BookE","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    BookD 1999; BookB 2000; BookA; BookC; BookE.
    """
