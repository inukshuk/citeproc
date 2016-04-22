Feature: condition
  As a CSL cite processor hacker
  I want the test condition_FirstNullAny to pass

  @citation @condition
  Scenario: First Null Any
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
          <text value="Try: "/>
          <choose>
            <if match="any" variable="publisher-place publisher">
              <text variable="publisher"/>
            </if>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-1","publisher":"Okay Publishers","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Try: Okay Publishers
    """
