Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_TitleWithCircumflex to pass

  @citation @textcase @citation-items
  Scenario: Title With Circumflex
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
          <text variable="title" text-case="title" quotes="true"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"About arvâsî","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | “About Arvâsî” |
