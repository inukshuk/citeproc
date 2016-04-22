Feature: condition
  As a CSL cite processor hacker
  I want the test condition_EmptyIsUncertainDateFalse to pass

  @citation @condition
  Scenario: Empty Is Uncertain Date False
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
            <if is-uncertain-date="issued">
              <text value="empty issued is uncertain"/>
            </if>
            <else>
              <text value="empty issued is not uncertain"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    empty issued is not uncertain
    """
