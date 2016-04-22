Feature: magic
  As a CSL cite processor hacker
  I want the test magic_NameParticle to pass

  @citation @magic
  Scenario: Name Particle
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
            <name name-as-sort-order="all" sort-separator=", "/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"dropping-particle":"von","family":"Doe","given":"John"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Doe, John von
    """
