Feature: number
  As a CSL cite processor hacker
  I want the test number_SimpleNumberOrdinalLong to pass

  @citation @number @citation-items
  Scenario: Simple Number Ordinal Long
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
          <number form="long-ordinal" variable="volume" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"item-1","title":"Ignore me","type":"book","volume":"42"},{"id":"item-2","title":"Ignore me too","type":"book","volume":"9"}]
    """
    When I cite the following items:
    """
    [[{"id":"item-1"}],[{"id":"item-2"}]]
    """
    Then the results should be:
      | 42nd  |
      | ninth |
