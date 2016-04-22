Feature: condition
  As a CSL cite processor hacker
  I want the test condition_VariableNone to pass

  @citation @condition
  Scenario: Variable None
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
        <layout delimiter="&#x0A;">
          <choose>
            <if variable="title edition" match="none">
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
    [{"id":"ITEM-1","type":"book"},{"id":"ITEM-2","title":"His Book","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    TRUE
    FALSE
    """
