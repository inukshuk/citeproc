Feature: name
  As a CSL cite processor hacker
  I want the test name_ParticleCaps1 to pass

  @citation @name @citation-items
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
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | (van One, van Two)    |
      | (van Three, Van Four) |
