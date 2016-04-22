Feature: date
  As a CSL cite processor hacker
  I want the test date_InPress to pass

  @citation @date
  Scenario: In Press
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
        <layout prefix="(" suffix=")">
          <group delimiter=" ">
            <names variable="author">
              <name/>
            </names>
            <date variable="issued" form="text" date-parts="year"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[],"literal":"(in press)"},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    (John Doe (in press))
    """
