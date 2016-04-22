Feature: number
  As a CSL cite processor hacker
  I want the test number_IsNumericWithAlpha to pass

  @citation @number
  Scenario: Is Numeric With Alpha
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
            <if is-numeric="edition">
              <text value="numeric"/>
            </if>
            <else>
              <text value="not numeric"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"edition":"annotated edition","id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    not numeric
    """
