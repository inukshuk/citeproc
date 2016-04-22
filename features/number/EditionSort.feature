Feature: number
  As a CSL cite processor hacker
  I want the test number_EditionSort to pass

  @citation @number
  Scenario: Edition Sort
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
        <sort>
          <key variable="edition"/>
        </sort>
        <layout delimiter=", ">
          <choose>
            <if is-numeric="edition">
              <number variable="edition" form="long-ordinal"/>
            </if>
            <else>
              <text variable="edition" form="short"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"edition":"2nd edition","id":"ITEM-1","title":"Item 1","type":"book"},{"edition":"3","id":"ITEM-2","title":"Item 2","type":"book"},{"edition":"special issue","id":"ITEM-3","title":"Item 3","type":"book"},{"edition":"1","id":"ITEM-4","title":"Item 4","type":"book"}]
    """
    And the following abbreviations:
    """
    {"default":{"number":{"2nd edition":"2nd"}}}
    """
    When I cite all items
    Then the result should be:
    """
    first, 2nd, third, special issue
    """
