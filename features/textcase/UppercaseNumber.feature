Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_UppercaseNumber to pass

  @citation @textcase
  Scenario: Uppercase Number
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
          <number variable="volume" form="roman" text-case="uppercase"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","type":"book","volume":"23"}]
    """
    When I cite all items
    Then the result should be:
    """
    XXIII
    """
