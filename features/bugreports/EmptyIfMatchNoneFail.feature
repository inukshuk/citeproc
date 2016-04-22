Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_EmptyIfMatchNoneFail to pass

  @citation @bugreports
  Scenario: Empty If Match None Fail
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
            <if match="none" variable="title"></if>
            <else-if match="any" type="thesis speech">
              <text variable="genre" />
            </else-if>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"genre":"PhD. diss.","id":"ITEM-1","title":"His Anonymous Life","type":"thesis"}]
    """
    When I cite all items
    Then the result should be:
    """
    PhD. diss.
    """
