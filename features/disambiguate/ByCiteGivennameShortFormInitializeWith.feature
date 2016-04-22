Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_ByCiteGivennameShortFormInitializeWith to pass

  @citation @disambiguate @citation-items
  Scenario: By Cite Givenname Short Form Initialize With
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
            <name form="short" initialize-with="" />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Doe","given":"Aloysius","static-ordering":false}],"id":"ITEM-3","type":"book"},{"author":[{"family":"Smith","given":"Thomas","static-ordering":false}],"id":"ITEM-4","type":"book"},{"author":[{"family":"Smith","given":"Ted","static-ordering":false}],"id":"ITEM-5","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"},{"id":"ITEM-3"}],[{"id":"ITEM-4"},{"id":"ITEM-5"}]]
    """
    Then the results should be:
      | Roe                     |
      | J Doe; A Doe            |
      | Thomas Smith; Ted Smith |
