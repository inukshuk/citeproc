Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_ByCiteTwoAuthorsSameCite to pass

  @citation @disambiguate
  Scenario: By Cite Two Authors Same Cite
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
             disambiguate-add-year-suffix="true"
             givenname-disambiguation-rule="by-cite">
        <layout delimiter="; ">
          <names delimiter=", " variable="author">
            <name and="text" delimiter=", " delimiter-precedes-last="never" form="short" initialize-with="." />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Collier","given":"Ruth Berins"},{"family":"Collier","given":"David"}],"id":15895,"issued":{"date-parts":[[2002]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Collier and Collier
    """
