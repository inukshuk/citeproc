Feature: position
  As a CSL cite processor hacker
  I want the test position_NearNoteTrue to pass

  @citation @position @citation-items
  Scenario: Near Note True
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
            <if position="near-note">
              <text value="Note is near!" />
            </if>
            <else>
              <text value="Note is not near." />
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book A","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","near-note":true,"position":1}]]
    """
    Then the results should be:
      | Note is near! |
