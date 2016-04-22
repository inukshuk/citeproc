Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_ItalicsFlipped to pass

  @citation @flipflop @citation-items
  Scenario: Italics Flipped
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
          <text font-style="italic" variable="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"One Two <i>Three</i> Four Five!","type":"book"},{"id":"ITEM-2","title":"One <i>Two <i>Three</i> Four</i> Five!","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | <i>One Two <span style="font-style:normal;">Three</span> Four Five!</i>  |
      | <i>One <span style="font-style:normal;">Two <i>Three</i> Four</span> Five!</i> |
