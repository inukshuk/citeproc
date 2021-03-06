Feature: position
  As a CSL cite processor hacker
  I want the test position_NearNoteUnsupported to pass

  @citation @position
  Scenario: Near Note Unsupported
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="in-text"
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
    When I cite all items
    Then the result should be:
    """
    Note is not near.
    """
