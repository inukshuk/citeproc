Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_CapsAfterOneWordPrefix to pass

  @citation @bugreports @citation-items
  Scenario: Caps After One Word Prefix
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
          <text term="ibid"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Title","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","prefix":"Nocapsafter. "}],[{"id":"ITEM-1","prefix":"Caps after. "}]]
    """
    Then the results should be:
      | Nocapsafter. ibid.  |
      | Caps after. Ibid.   |
