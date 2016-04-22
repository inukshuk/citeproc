Feature: date
  As a CSL cite processor hacker
  I want the test date_SortEmptyDatesBibliography to pass

  @bibliography @date
  Scenario: Sort Empty Dates Bibliography
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
          <text value="Hello"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="issued"/>
          <key variable="title"/>
        </sort>
        <layout prefix="" suffix=".">
          <group delimiter=" ">
            <text variable="title" />
            <date variable="issued">
              <date-part name="year" />
            </date>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"BookA","type":"book"},{"id":"ITEM-2","issued":{"date-parts":[[2000]]},"title":"BookB","type":"book"},{"id":"ITEM-3","title":"BookC","type":"book"},{"id":"ITEM-4","issued":{"date-parts":[[1999]]},"title":"BookD","type":"book"},{"id":"ITEM-5","title":"BookE","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">BookD 1999.</div>
      <div class="csl-entry">BookB 2000.</div>
      <div class="csl-entry">BookA.</div>
      <div class="csl-entry">BookC.</div>
      <div class="csl-entry">BookE.</div>
    </div>
    """
