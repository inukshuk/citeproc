Feature: position
  As a CSL cite processor hacker
  I want the test position_NearNoteSameNote to pass

  @citation @position @citations
  Scenario: Near Note Same Note
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
      <citation near-note-distance="0">
        <layout delimiter="; ">
          <choose>
            <if position="ibid near-note" match="all">
              <text variable="title" prefix="Near+Ibid:"/>
            </if>
            <else>
              <text variable="title" prefix="Plain+Vanilla:"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book-A","type":"book"},{"id":"ITEM-2","title":"Book-B","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Plain+Vanilla:Book-A; Near+Ibid:Book-A
    ..[1] Plain+Vanilla:Book-B
    >>[2] Plain+Vanilla:Book-B; Plain+Vanilla:Book-A
    """
