Feature: name
  As a CSL cite processor hacker
  I want the test name_NonDroppingParticleDefault to pass

  @citation @name
  Scenario: Non Dropping Particle Default
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
            <name name-as-sort-order="all"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Roe","given":"Jane","non-dropping-particle":"van","static-ordering":false}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Roe, Jane van
    """
