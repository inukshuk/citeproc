Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_ToInitialOnly to pass

  @citation @disambiguate
  Scenario: To Initial Only
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
             givenname-disambiguation-rule="all-names-with-initials">
        <layout delimiter="; ">
          <names delimiter=", " variable="author">
            <name and="text" 
                  delimiter-precedes-last="never" 
                  initialize-with="." form="short"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"Cecil"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Smith","given":"Charles"}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Muggins","given":"Bob"}],"id":"ITEM-3","type":"book"},{"author":[{"family":"Muggins","given":"Jardine"}],"id":"ITEM-4","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Smith; Smith; B. Muggins; J. Muggins
    """
