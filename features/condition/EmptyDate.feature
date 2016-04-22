Feature: condition
  As a CSL cite processor hacker
  I want the test condition_EmptyDate to pass

  @citation @condition @citation-items
  Scenario: Empty Date
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
            <if variable="issued">
              <text value="Have date, will travel" />
            </if>
            <else>
              <text value="No date here" />
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","title":"Work 1","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[[2000]]},"title":"Work 2","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | No date here  |
      | Have date, will travel |
