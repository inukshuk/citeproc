Feature: affix
  As a CSL cite processor hacker
  I want the test affix_MovingPunctuation to pass

  @citation @affix @citation-items
  Scenario: Moving Punctuation
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
      <locale>
        <style-options punctuation-in-quote="true"/>
      </locale>
      <citation>
        <layout delimiter="; ">
          <text variable="title" quotes="true"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"The Title","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","suffix":". And \"so it goes\""}]]
    """
    Then the results should be:
      | “The Title.” And “so it goes” |
