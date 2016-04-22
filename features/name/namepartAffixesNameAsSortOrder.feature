Feature: name
  As a CSL cite processor hacker
  I want the test name_namepartAffixesNameAsSortOrder to pass

  @citation @name
  Scenario: namepart Affixes Name As Sort Order
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
          <names variable="author">
            <name name-as-sort-order="all" sort-separator=" ">
              <name-part name="family" prefix="(" suffix=")"/>
              <name-part name="given" prefix="[" suffix="]"/>
            </name>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"dropping-particle":"de","family":"Fontaine","given":"Jean","non-dropping-particle":"La","suffix":"III"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    (La Fontaine) [Jean de] III
    """
