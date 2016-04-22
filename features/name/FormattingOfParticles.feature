Feature: name
  As a CSL cite processor hacker
  I want the test name_FormattingOfParticles to pass

  @citation @name
  Scenario: Formatting Of Particles
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
            <name>
              <name-part name="family" text-case="uppercase"/>
            </name>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"dropping-particle":"van","family":"Meer","given":"Gerard","non-dropping-particle":"der"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Gerard van DER MEER
    """
