Feature: name
  As a CSL cite processor hacker
  I want the test name_ParsedCommaDelimitedDroppingParticleNormalOrderingWithoutAffixes to pass

  @citation @name
  Scenario: Parsed Comma Delimited Dropping Particle Normal Ordering Without Affixes
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          demote-non-dropping-particle="never">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <names variable="author">
            <name/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aubignac","given":"François Hédelin, abbé d'"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    François Hédelin, abbé d’Aubignac
    """
