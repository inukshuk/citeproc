Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_SingleBeforeColon to pass

  @citation @flipflop @citation-items
  Scenario: Single Before Colon
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
          <text text-case="title" variable="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"'Nobody Knows You're a Dog': As iconic Internet cartoon turns 20, creator Peter Steiner knows the joke rings as relevant as ever","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | “Nobody Knows You’re a Dog”: As Iconic Internet Cartoon Turns 20, Creator Peter Steiner Knows the Joke Rings as Relevant as Ever |
