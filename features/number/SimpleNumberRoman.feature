Feature: number
  As a CSL cite processor hacker
  I want the test number_SimpleNumberRoman to pass

  @citation @number
  Scenario: Simple Number Roman
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
          <number form="roman" variable="volume" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"item-1","title":"Ignore me","type":"book","volume":"42"}]
    """
    When I cite all items
    Then the result should be:
    """
    xlii
    """
