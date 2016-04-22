Feature: date
  As a CSL cite processor hacker
  I want the test date_LopsidedDataYearSuffixCollapse to pass

  @citation @date
  Scenario: Lopsided Data Year Suffix Collapse
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
      <citation collapse="year-suffix"
                disambiguate-add-year-suffix="true"
                year-suffix-delimiter=","
                after-collapse-delimiter="; ">
        <layout prefix="(" suffix=")" delimiter=", ">
          <group delimiter=" ">
            <names variable="author">
              <name form="short"/>
            </names>
            <group>
              <date variable="issued" date-parts="year" form="text"/>
            </group>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[],"raw":"Jun 1982"},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[],"raw":"1982-10-1"},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    (Smith 1982a,b)
    """
