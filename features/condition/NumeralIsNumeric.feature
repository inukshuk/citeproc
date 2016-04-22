Feature: condition
  As a CSL cite processor hacker
  I want the test condition_NumeralIsNumeric to pass

  @citation @condition
  Scenario: Numeral Is Numeric
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
              <text value="TRUE"/>
            </if>
            <else>
              <text value="FALSE"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"edition":"5","id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    TRUE
    """
