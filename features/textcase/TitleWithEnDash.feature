Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_TitleWithEnDash to pass

  @citation @textcase @citation-items
  Scenario: Title With En Dash
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
          <text variable="title" text-case="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Closing the scientist–practitioner gap: studies from 2016 with significant practical utility","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | Closing the Scientist–Practitioner Gap: Studies from 2016 with Significant Practical Utility |
