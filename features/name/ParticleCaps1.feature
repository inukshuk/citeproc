Feature: name
  As a CSL cite processor hacker
  I want the test name_ParticleCaps1 to pass

  @citation @name @citations
  Scenario: Particle Caps1
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          demote-non-dropping-particle="sort-only">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <group prefix="(" suffix=")">
            <names variable="author" delimiter="; ">
              <name delimiter=", " form="short"/>
            </names>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"van One","given":"Onename"},{"family":"van Two","given":"Twoname"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"van Three","given":"Threename"},{"family":"Van Four","given":"Fourname"}],"id":"ITEM-2","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] (van One, van Two)
    >>[1] (van Three, Van Four)
    """
