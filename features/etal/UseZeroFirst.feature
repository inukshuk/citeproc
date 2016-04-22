Feature: etal
  As a CSL cite processor hacker
  I want the test etal_UseZeroFirst to pass

  @bibliography @etal
  Scenario: Use Zero First
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
          <text value="Oops"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter=" // ">
            <names variable="author">
              <name et-al-min="2" et-al-use-first="0"/>
            </names>
            <names variable="author">
              <name et-al-min="2" et-al-use-first="1"/>
            </names>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"}],"id":"ITEM-1","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">John Doe et al.</div>
    </div>
    """
