Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_ByCiteGivennameNoShortFormInitializeWith to pass

  @citation @disambiguate @citation-items
  Scenario: By Cite Givenname No Short Form Initialize With
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
             givenname-disambiguation-rule="by-cite">
        <layout delimiter="; ">
          <names variable="author">
            <name initialize-with="" />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Doe","given":"Jack","static-ordering":false}],"id":"ITEM-3","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"},{"id":"ITEM-3"}]]
    """
    Then the results should be:
      | J Roe              |
      | John Doe; Jack Doe |
