Feature: name
  As a CSL cite processor hacker
  I want the test name_ParticleParse1 to pass

  @citation @name @citation-items
  Scenario: Particle Parse1
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
          <names variable="author">
            <name form="short" />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"George von und zum"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"von und zum Jones","given":"Ralph"}],"id":"ITEM-2","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | Smith             |
      | von und zum Jones |
