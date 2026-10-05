Feature: locator
  As a CSL cite processor hacker
  I want the test locator_WorkaroundTestForSubVerbo to pass

  @citation @locator @citation-items
  Scenario: Workaround Test For Sub Verbo
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
      <macro name="locator-refs">
        <choose>
          <if locator="book chapter column figure folio issue line note opus page paragraph part section verse volume" match="none">
            <text variable="locator" prefix=", "/>
          </if>
          <else>
            <label variable="locator" form="short" prefix=", "/>
            <text variable="locator" prefix=" "/>
          </else>
        </choose>
      </macro>
      <citation>
        <layout>
          <text variable="title"/>
          <text macro="locator-refs" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book With Opus","type":"book"},{"id":"ITEM-2","title":"Book With Sub Verbo","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","label":"opus","locator":"100"}],[{"id":"ITEM-2","label":"sub verbo","locator":"200"}]]
    """
    Then the results should be:
      | Book With Opus, op. 100  |
      | Book With Sub Verbo, 200 |
