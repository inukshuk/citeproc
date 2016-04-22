Feature: condition
  As a CSL cite processor hacker
  I want the test condition_IsNumeric to pass

  @citation @condition @citation-items
  Scenario: Is Numeric
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
          <choose>
            <if is-numeric="volume">
              <text value="Numeric true:" suffix=" "/>
              <number variable="volume"/>
            </if>
            <else>
              <text value="Numeric false:" suffix=" "/>
              <number variable="volume"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Work 1","type":"book","volume":"Volume 2"},{"id":"ITEM-2","title":"Work 2","type":"book","volume":"2nd volume"},{"id":"ITEM-3","title":"Work 3","type":"book","volume":"Second vol."}]
    """
    And the following abbreviations:
    """
    {"default":{"number":{"2nd volume":"2nd"}}}
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}],[{"id":"ITEM-3"}]]
    """
    Then the results should be:
      | Numeric false: Volume 2 |
      | Numeric true: 2nd  |
      | Numeric false: Second vol. |
