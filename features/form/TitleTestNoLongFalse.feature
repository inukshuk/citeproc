Feature: form
  As a CSL cite processor hacker
  I want the test form_TitleTestNoLongFalse to pass

  @citation @form
  Scenario: Title Test No Long False
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
            <if variable="title">
              <text value="true"/>
            </if>
            <else>
              <text value="false"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","shortTitle":"Book A","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    false
    """
