Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_LastOnlyFailWithByCite to pass

  @citation @disambiguate @citations
  Scenario: Last Only Fail With By Cite
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="in-text"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation et-al-min="4" 
                et-al-use-first="1" 
                et-al-subsequent-min="4" 
                et-al-subsequent-use-first="1" 
                disambiguate-add-givenname="true" 
                givenname-disambiguation-rule="by-cite" 
                disambiguate-add-year-suffix="true" 
                collapse="year">
        <layout delimiter="; ">
          <group delimiter=", ">
            <group delimiter=" ">
              <names variable="author">
                 <name initialize-with=". "/>
              </names>
              <date variable="issued" date-parts="year" form="text"/>
            </group>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Organisation"}],"event-place":"Canberra","id":"ITEM-1","issued":{"date-parts":[[2010]]},"key":"QXTWKDFN","publisher-place":"Canberra","title":"blah","type":"report"},{"author":[{"family":"Organisation"}],"event-place":"Melbourne","id":"ITEM-2","issued":{"date-parts":[[2010]]},"key":"HE34J5AE","publisher-place":"Melbourne","title":"blash","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Organisation 2010a
    >>[1] Organisation 2010b
    """
