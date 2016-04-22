Feature: punctuation
  As a CSL cite processor hacker
  I want the test punctuation_DoNotSuppressColonAfterPeriod to pass

  @citation @punctuation
  Scenario: Do Not Suppress Colon After Period
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
          <text variable="publisher-place" suffix=": "/>
          <text variable="publisher"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","publisher":"Random","publisher-place":"Detroit, Mich.","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Detroit, Mich.: Random
    """
