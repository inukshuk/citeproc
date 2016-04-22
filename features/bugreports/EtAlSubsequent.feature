Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_EtAlSubsequent to pass

  @citation @bugreports @citations
  Scenario: Et Al Subsequent
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
      <citation
        et-al-min="5"
        et-al-use-first="1"
        et-al-subsequent-min="3"
        et-al-subsequent-use-first="1">
        <layout>
          <names variable="author">
    	    <name/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"},{"family":"Harper","given":"Katie"},{"family":"Clutterbuck","given":"Emmanuel"}],"id":"ITEM-1","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] John Doe, Jane Roe, Katie Harper, Emmanuel Clutterbuck
    >>[1] John Doe et al.
    """
