Feature: sort
  As a CSL cite processor hacker
  I want the test sort_LocalizedDateLimitedParts to pass

  @citation @sort
  Scenario: Localized Date Limited Parts
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
      <macro name="date">
        <date variable="issued" date-parts="year" form="numeric"/>
      </macro>
      <citation>
        <sort>
          <key macro="date" />
          <key variable="title" />
        </sort>
        <layout delimiter="; ">
          <text variable="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[["2000","11","2"]]},"title":"Book A","type":"book"},{"id":"ITEM-2","issued":{"date-parts":[["2001"]]},"title":"Book C","type":"book"},{"id":"ITEM-3","issued":{"date-parts":[["1999"]]},"title":"Book D","type":"book"},{"id":"ITEM-4","issued":{"date-parts":[["2000","11","1"]]},"title":"Book B","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Book D; Book A; Book B; Book C
    """
