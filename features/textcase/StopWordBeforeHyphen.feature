Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_StopWordBeforeHyphen to pass

  @citation @textcase @citation-items
  Scenario: Stop Word Before Hyphen
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
          <text variable="container-title" text-case="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"Employee pro-environmental behavior","id":"ITEM-1","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | Employee Pro-Environmental Behavior |
