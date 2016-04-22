Feature: condition
  As a CSL cite processor hacker
  I want the test condition_EmptyShortTitleFalse to pass

  @citation @condition
  Scenario: Empty Short Title False
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
            <if variable="title-short">
              <text value="Sees title-short (wrong)"/>
            </if>
            <else>
              <text value="Does not see title-short (correct)"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"His Anonymous Life","type":"legal_case"}]
    """
    When I cite all items
    Then the result should be:
    """
    Does not see title-short (correct)
    """
