Feature: api
  As a CSL cite processor hacker
  I want the test api_UpdateItemsDeleteDecrementsByCiteDisambiguation to pass

  @citation @api @bibentries
  Scenario: Update Items Delete Decrements By Cite Disambiguation
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
        <layout delimiter="; " suffix=".">
          <group delimiter=" ">
            <names variable="author">
              <name initialize-with="" />
            </names>
            <date variable="issued">
              <date-part name="year" />
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[[1960]]},"title":"Book A","type":"book"},{"author":[{"family":"Doe","given":"Jake","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[[1960]]},"title":"Book B","type":"book"},{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-3","issued":{"date-parts":[[1980]]},"title":"Book C","type":"book"},{"author":[{"family":"Brown","given":"Robert","static-ordering":false}],"id":"ITEM-4","issued":{"date-parts":[[1990]]},"title":"Book D","type":"book"},{"author":[{"family":"Ichi","given":"Taro","static-ordering":false}],"id":"ITEM-5","issued":{"date-parts":[[2000]]},"title":"Book E","type":"book"}]
    """
    And the following items have been cited:
    """
    ["ITEM-1","ITEM-4","ITEM-5"]
    """
    When I cite all items
    Then the result should be:
    """
    J Doe 1960; R Brown 1990; T Ichi 2000.
    """
