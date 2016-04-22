Feature: number
  As a CSL cite processor hacker
  I want the test number_FailingDelimiters to pass

  @bibliography @number
  Scenario: Failing Delimiters
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
          <text value="DUMMY"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter="[x]">
            <text variable="title"/>
            <number variable="volume"/>
            <number variable="issue" prefix=":"/>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issue":555,"title":"His Anonymous Life","type":"book","volume":100}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">His Anonymous Life[x]100[x]:555</div>
    </div>
    """
