Feature: condition
  As a CSL cite processor hacker
  I want the test condition_LocatorIsFalse to pass

  @citation @condition @citation-items
  Scenario: Locator Is False
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
        <layout delimiter="; ">
    	  <text variable="title" suffix=": "/>
          <choose>
            <if variable="locator">
              <text value="(1) Locator true"/>
            </if>
            <else>
              <text value="(1) Locator false"/>
            </else>
          </choose>
          <choose>
            <if variable="locator" match="none">
              <text value=" (2) Locator false"/>
            </if>
            <else>
              <text value=" (2) Locator true"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book One","type":"book"},{"id":"ITEM-2","title":"Book Two","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","locator":"1"},{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | Book One: (1) Locator true (2) Locator true; Book Two: (1) Locator false (2) Locator false |
