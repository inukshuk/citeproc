Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_DifferentSpacingInInitials to pass

  @citation @disambiguate
  Scenario: Different Spacing In Initials
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
      <citation
        disambiguate-add-givenname="true"
        givenname-disambiguation-rule="all-names">
        <layout delimiter="; ">
          <group delimiter=", ">
            <names variable="author">
              <name form="short" initialize-with=". " name-as-sort-order="first" sort-separator=", "/>
            </names>
            <text variable="title"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"J. J.","static-ordering":false}],"id":"ITEM-1","title":"His Anonymous Life (part 1)","type":"book"},{"author":[{"family":"Doe","given":"J.J.","static-ordering":false}],"id":"ITEM-2","title":"His Anonymous Life (part 2)","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Doe, His Anonymous Life (part 1); Doe, His Anonymous Life (part 2)
    """
