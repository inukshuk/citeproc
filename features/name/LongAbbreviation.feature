Feature: name
  As a CSL cite processor hacker
  I want the test name_LongAbbreviation to pass

  @citation @name
  Scenario: Long Abbreviation
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
          <names variable="author">
            <name initialize-with="." />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Tserendorj","given":"TSerendorjiin","static-ordering":false}],"id":"simple-mongolian-name-1","issued":{"date-parts":[["1925","3","4"]]},"title":"An Altogether Unknown History of Soviet-Mongolian Relations","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Ts. Tserendorj
    """
